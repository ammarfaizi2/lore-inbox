Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUHQLR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUHQLR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUHQLR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:17:26 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:54225 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265410AbUHQLPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:15:38 -0400
Date: Tue, 17 Aug 2004 13:14:59 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408171114.i7HBExCu028332@burner.fokus.fraunhofer.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If the programs must be set suid, is that safe? In the past I was
>always told that setting e.g. cdrecord suid was a possible security issue.
>But I really don't understand enough of the new security model in the
>kernel to judge if that's right or wrong...

Judging from the number of reports, I would guess that the Linux kernel is
much more insecure than cdrecord.

What some people did (chmod on /dev/ entries) was definitely always a bigger
security risk than running cdrecord suid root.

What SuSE tries (writing a resource manager) is also a bigger security risk
then cdrecord itself (at least as long as it is not done decently).

There has been only one expliot for cdrecord so far and a fix has been available
within hours (long before the exploit has been made public). There has been
one additional possible buffer overflow (reported by the author of the SuSE 
resource manager who did not respond after I told him why the SuSE resource 
manager is a security risk).

Cdrecord has been converted to run with effective id 0 only in the start up 
phase 1.5 years ago. It has been enabled to work with Sun's security 
enhancements (euid 0 is needed for ioctl USCSI) 8 months ago.

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



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
