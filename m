Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUHUMoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUHUMoX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 08:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUHUMoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 08:44:23 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:14056 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264726AbUHUMoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 08:44:20 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sat, 21 Aug 2004 14:43:22 +0200
To: schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       fsteiner-mail@bio.ifi.lmu.de, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4127436A.nail9BA11B882@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <d577e5690408190004368536e9@mail.gmail.com>
 <4124A024.nail7X62HZNBB@burner> <4124BA10.6060602@bio.ifi.lmu.de>
 <1092925942.28353.5.camel@localhost.localdomain>
 <4125E5B9.nail8LD2EG3NM@burner>
 <1093001143.30940.23.camel@localhost.localdomain>
 <41260675.nail8LDG1UIJL@burner>
 <1093009555.30941.48.camel@localhost.localdomain>
In-Reply-To: <1093009555.30941.48.camel@localhost.localdomain>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2004-08-20 at 15:11, Joerg Schilling wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> > > > On a decently administrated Linux system, only root is able to send SCSI 
> > > > commands because only root is able to open the apropriate /dev/* entries.
> > >
> > > Wrong (as usual)
> > 
> > Useless as usual :-(
>
> Unlike you I spend some of my time looking at large real world Linux
> installations.

So you just like to tell us that you have no clue?

If the owners and permissions of the filesystem have been set up correctly,
then there is no security problem. 

As there is no problem in the kernel, why change the kernel?

The modification only breaks compatibility and causes trusted applications
like cdrtools to fail if installed suid root.

The change _only_ affects programs that open the /dev/ nodes with euid root
and later revert to a different user id. 

Programs that do not run with euid root cannot open the /dev/ nodes if owner
and permissions have been set up correctly.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
