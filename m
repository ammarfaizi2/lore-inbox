Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbRBOTK4>; Thu, 15 Feb 2001 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRBOTKq>; Thu, 15 Feb 2001 14:10:46 -0500
Received: from slc839.modem.xmission.com ([166.70.6.77]:43271 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129852AbRBOTKh>; Thu, 15 Feb 2001 14:10:37 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Feb 2001 09:00:48 -0700
In-Reply-To: Manfred Spraul's message of "Thu, 15 Feb 2001 16:29:49 +0100"
Message-ID: <m1k86s6imn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> "Eric W. Biederman" wrote:
> > 
> > But the gcc bounds checking work is the ultimate buffer overflow fix.
> > You can recompile all of your trusted applications, and libraries with
> > it and be safe from one source of bugs.
> >
> 
> void main(int argc, char **argv[])
> {
> 	char local[128];
> 	if(argc > 2)
> 		strcpy(local,argv[1]);
> }
> 
> Unless you modify the ABI and pass the array bounds around you won't
> catch such problems, 

Of course.  But this is linux and you have the source.  And I did mention
you needed to recompile the libraries your trusted applications depended on.


> and I won't even mention unions and
> 
> struct dyn_data {
> 	int len;
> 	char data[];
> }

Yep bounds checking is not an easy fix.  But it is a good fix.

Eric
