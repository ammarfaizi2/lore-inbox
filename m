Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314107AbSDLSQO>; Fri, 12 Apr 2002 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314131AbSDLSQO>; Fri, 12 Apr 2002 14:16:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39235 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314107AbSDLSQN>; Fri, 12 Apr 2002 14:16:13 -0400
To: Blue Lang <blue@b-side.org>
Cc: Michael De Nil <linux@aerythmic.be>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: i830M video chip (X driver deficient)
In-Reply-To: <Pine.LNX.4.30.0204121305430.17120-100000@gib.soccerchix.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Apr 2002 12:09:21 -0600
Message-ID: <m1ofgokcvi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blue Lang <blue@b-side.org> writes:

> On 12 Apr 2002, Eric W. Biederman wrote:
> 
> > It isn't memory related at all.  The problem is that the X driver uses
> > the video BIOS to set the display modes, instead of setting the
> > display mode by itself as it should.  I don't know if there are enough
> > docs available from intel about this but that is the problem.
> 
> erm.. I thought that's what I said. Anyways, here is that link I was
> talking about:
> 
> http://www.cse.unsw.edu.au/~chak/linux/c400.html
> 

My point the problem is not memory or the BIOS not allocating enough
memory.  The problem is (a) using the BIOS and (b) the BIOS not believing
it can to do the job when X has enough memory.

All I have seen in the X error messages was an error message that the BIOS
could not set the video mode.  My response, why the heck is the driver
doing BIOS calls.  I'm not a fan at all of using someone else's drivers
after the kernel loads.

Heck I'm not even a fan of using a closed source BIOS.

Eric
