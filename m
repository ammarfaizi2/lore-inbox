Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUHSQI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUHSQI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUHSQI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:08:29 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:25256 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266574AbUHSQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:08:27 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 19 Aug 2004 18:07:30 +0200
To: B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4124D042.nail85A1E3BQ6@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <4124BA10.6060602@bio.ifi.lmu.de>
 <1092925942.28353.5.camel@localhost.localdomain>
 <200408191800.56581.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200408191800.56581.bzolnier@elka.pw.edu.pl>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

>> As a security fix it was sufficiently important that it had to be done.

>IMO work-rounding this in kernel is a bad idea and could break a lot of 
>existing apps (some you even don't know about).  Much better way to deal with 
>this is to create library for handling I/O commands submission and gradually 
>teach user-space apps to use it.

This is exactly what libscg is for...... 
libscg already includes similar support for Solaris 9 & Solaris 10.

Cdrtools is is code freeze state. This is why I say the best idea is to remove 
this interface change from the current Linux kernel and wait until there will
be new cdrtools alpha for 2.02 releases. These alpha could get support for uid
switching. If Linux then would again switch the changes on, it makes sense.

BTW: it makes absolutely no sense to have a list of "safe" commands in the kernel
as the kernel simply cannot know which SCSI commands are "safe" and which not.
The list would be if ever subject to changess on a dayly base which is a real 
bad idea.

Note that having such a list of aparently safe commands would cause a lot of
untracable problems (why does it run for you but not for me....).


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
