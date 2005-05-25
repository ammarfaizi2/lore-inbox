Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVEYNTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVEYNTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVEYNSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:18:09 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:15093 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262185AbVEYNQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:16:22 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 May 2005 15:15:33 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <42947A75.nail1XA2FQPXX@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland wrote:

>I was refering to the 2.6 permissions bug in cdrecord. It wouldn't work using 
>a non-root user, even if they had the correct permissions. 2.6 changed (for 
>the better, mind you), and Joerg refused to fix cdrecord. (I don't know if 
>its even fixed now). Theres been other cases of cdrecord breaking on Linux 
>only, but I can't think of them atm. 

Well, it seems that you are uninformed about the facts :-(

So let me quote a mail I send to LKML on Aug 17 13:14:59 2004:
/*--------------------------------------------------------------------------*/
If Linux believes that there should be enhanced security similar to Solaris and  
if Linux is a true open Source business, then I would expect that there is  
cooperation. If I change things in e.g. mkisofs or cdrecord that could result 
in problems for my "users", I send a notification mail to the XCDRoast & k3b  
authors early enough. 
 
If Linux plans to implement incompatible changes, I would expect that  
"important users" are informed in advance so that it is possible to discuss the  
problems an to have a planned smooth migration. As this did not happen, the  
change needs to be called a bug. This is even more obvious if we take into  
account that cdrtools curently is in code freeze state as a 2.01-final will  
come the next days. 
 
For this reason, I would recommend that Linux immediately goes back to the old 
behavior and informs "important users". A change that has effects that are as 
widely as this one should not be tried again within the next 3 months. Then  
there is a change to have a smooth migration...... 
 
BTW: I try to inform my "important users" more than a year before I introduce 
important changes. 
/*--------------------------------------------------------------------------*/

Note that this was a few days before cdrtools-2.01 final have been published
(after nearly two years of planned work on a new version).

The changes to Linux did neither fix the problem (just check the mailings on 
LKML from last year) nor has there been a need for introducing incompatible 
changes. If the cause for the change really was the "security problem" caused 
by the fact that Linux did allow to send SCSI commands on R/O file descriptors
it would have been sufficient to require R/W permissions on the fd. After
this putative small change, the supposed problem would have been fixed and 
cdrtools as well as other users of the interface did work as before.

What the change on Linux did was not to fix a problem but to break cdrtools.

I am not unwilling to fix cdrecored, as a non broken program does not need
a fix. I was even willing to add a workaround for the incompatible interface 
change. But this may obviously not happen in a code freeze state.

Sorry - The problems between cdrtools and Linux is only a result of the 
missing will for cooperation from the Linux kernel crew.


BTW: Due to missing time (I like to see a good cooperation between my work
and the support code in an OS, so I am now actively working on OpenSolaris
and I am very busy...). My planned OpenSolaris based UNIX distribution
"SchilliX" should be available soon after the public availability of the
OpenSolaris source in Q2/2005 which is only a few days from now. Fortunately,
I believe that I will be able to boot my first "SchilliX from scratch" 
compiled CD today.

P.S.: About 10 days ago, I made an attempt to include a workaround for the
interface changes in Linux, check cdrtools-2.01.01a03


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
