Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUHTLwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUHTLwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUHTLwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:52:42 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:1926 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266578AbUHTLw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:52:27 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 20 Aug 2004 13:51:21 +0200
To: fsteiner-mail@bio.ifi.lmu.de, alan@lxorguk.ukuu.org.uk
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4125E5B9.nail8LD2EG3NM@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <d577e5690408190004368536e9@mail.gmail.com>
 <4124A024.nail7X62HZNBB@burner> <4124BA10.6060602@bio.ifi.lmu.de>
 <1092925942.28353.5.camel@localhost.localdomain>
In-Reply-To: <1092925942.28353.5.camel@localhost.localdomain>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> You can also erase the drive firmware as a user etc. That's the problem.

This is definitely not a "hot" problem so there is absolutely no reason to 
make incompatible changes in the kernel interface _without_ discussing this
with the most important users before.

On a decently administrated Linux system, only root is able to send SCSI 
commands because only root is able to open the apropriate /dev/* entries.

cdrecord is designed to be safely installed root and cdrecord is trustworthy - 
it does not overwrite the drive's firmware.

pxupgrade is not intended to be installed suid root, but _even_ _if_ someone
does, it will not allow you to write a file that has not been verifed to be
valid firmware for the drive in question.

> As a security fix it was sufficiently important that it had to be done.

You completely missimterpret importance :-(

Conclusion: What Linux-2.6.8 implement is a bug :-(

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
