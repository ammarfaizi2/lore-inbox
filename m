Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132838AbRDXHGu>; Tue, 24 Apr 2001 03:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbRDXHGl>; Tue, 24 Apr 2001 03:06:41 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:14597 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132838AbRDXHG0>; Tue, 24 Apr 2001 03:06:26 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: FAVRE Gregoire <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod take all CPU and I can't stop it under 2.4.3-ac{9,11} 
In-Reply-To: Your message of "Sun, 22 Apr 2001 10:42:06 +0200."
             <20010422104206.A2939@ulima.unil.ch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 17:06:15 +1000
Message-ID: <19300.988095975@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2001 10:42:06 +0200, 
FAVRE Gregoire <greg@ulima.unil.ch> wrote:
>I am using DVB and sometimes I have to reload the driver, some times, I
>can just do it without problem, but often, it result in a (from top):
> 1359 root      19   0   532  532   360 R    77.7  0.2   8:32 rmmod

It is not rmmod that is looping, it is the module's cleanup routine
that is looping in kernel space (where it cannot be killed).  Contact
the maintainer for the module that you are trying to remove.

