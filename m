Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317972AbSGPRr6>; Tue, 16 Jul 2002 13:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317973AbSGPRr5>; Tue, 16 Jul 2002 13:47:57 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:22436 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317972AbSGPRr4>; Tue, 16 Jul 2002 13:47:56 -0400
Date: Tue, 16 Jul 2002 19:49:11 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161749.g6GHnBZ2027359@burner.fokus.gmd.de>
To: jauderho@carumba.com, schilling@fokus.gmd.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jauder Ho <jauderho@carumba.com>

>And path_to_inst does not always do the RightThing(tm). [1] [2] Two
>systems identically configured has the potential of having path_to_inst
>look different. Especially if you have previously installed a device or
>moved stuff around. And if the expectation is that a group of devices will
>come up in a certain sequence (think shared tape devices for instance) and
>it changes, it quickly becomes a nightmare. Not a fun proposition by any
>means.

The Solaris /etc/path_to_inst method works 99.9% as expected. And important,
it is very stable in special for novice users. If you really have the problems 
as described, you could alwas edit /etc/path_to_inst manually and reboot.
Please note: If you install two systems with te same hardware configuration the 
same way _and_ in the same _order_, the will have an identical 
/etc/path_to_inst.

If I have to decide between a mostly rock solid system and a system that always 
behaves in a way that is not predictable, I would take the first one.


>[1] eg http://www.myri.com/scs/documentation/mug/installation/solaris.html

The author of this driver lacks the needed experience in writing DLPI drivers.
Although this lack of knowledge seems to be not uncommon (the FORE ATM driver 
is broken too), it is possible to do it right. The ATM DLPI driver I did write 
in 1995 did work correctly after I did educate me about the correct interface.
You simply need to be able to deal with the fact that instance #0 os a driver 
is not present while one or more instances with instance # > 0 _are_ present.

>[2] http://www.magma.com/support/sun.htm

Looks like a similar problem as above.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
