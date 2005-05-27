Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVE0Kpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVE0Kpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVE0Kpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:45:47 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:11957 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262431AbVE0Kpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:45:40 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 May 2005 12:44:31 +0200
To: patrakov@ums.usu.ru, 7eggert@gmx.de
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Message-ID: <4296FA0F.nail3N041ODQE@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <4295005F.nail2KW319F89@burner>
 <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
 <200505260945.01886.patrakov@ums.usu.ru>
 <Pine.LNX.4.58.0505261335440.2939@be1.lrz>
 <4295C217.2040005@ums.usu.ru>
 <Pine.LNX.4.58.0505261651220.3407@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0505261651220.3407@be1.lrz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:

> On Thu, 26 May 2005, Alexander E. Patrakov wrote:
> > Bodo Eggert wrote:
>
> > >So we can
> > >
> > >1) give up and let any application with write access destroy the hardware
>
> > That won't be a problem if all apps with write access are running as 
> > root or setuid and thus the list of them is well-controlled by root.
>
> And if all these apps are guaranteed to have no buffer-overflow or other 
> exploits.

If you cleanly separate the ability to send SCSI commands from the ability
to write to a UNIX block or raw devive, you only need to check the programs
that explicitly need to send SCSI commands.

In former times, Linux did have this kind of clean separation between
e.g. /dev/sd0 and /dev/sg0. Just go back to the clean old model...

This could easily be done: Remove SG_IO from the list of ioctl functions
supported by drivers like /dev/sd0 and /dev/hda fix the bugs in ide_scsi.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
