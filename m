Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRKHVY7>; Thu, 8 Nov 2001 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278470AbRKHVYt>; Thu, 8 Nov 2001 16:24:49 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16654 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S278450AbRKHVYl>;
	Thu, 8 Nov 2001 16:24:41 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Frank de Lange <frank@unternet.org>
Date: Thu, 8 Nov 2001 22:24:05 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <89FED3F0389@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Nov 01 at 21:36, Frank de Lange wrote:
> On Thu, Nov 08, 2001 at 09:08:10PM +0000, Petr Vandrovec wrote:
> > Is it really solid freeze (what does alt-sysrq-s,u,s,b)? 
> 
> Solid as a rock, nothing responds anymore. You can sit an elephant on the
> keyboard and it won't respond.
> 
> Only the big white switch helps (fsck'ing 80 gigs gives me enough time to make
> a good cup of coffee... time for ext3 in the main kernel series...)

Journaling will not do anything good in such case, as damaged kernel
could write damaged data to your harddisk. You should run full fsck
after every such lockup even if you are using journaled filesystem -
- unless you are 100% sure that kernel really stoped doing anything
instead of that it started doing strange things.
 
> Have you investigated the problems any further? I mean, does it hang in the
> vmware module (probably vmmon as it does not seem to be related to network or
> other peripheral activity), or is it somewhere in the main kernel code?

As there are no loops in vmmon, it is mathematically provable that it
did not end in endless loop with interrupts disabled inside vmmon ;-) 
But it could die anywhere else. 

Probably it is time for me to try Linus's kernel, but I have so perfect 
exprience with Alan ones that I'm a bit reluctant to do that.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
