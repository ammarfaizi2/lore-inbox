Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161465AbWBUKiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161465AbWBUKiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWBUKiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:38:14 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:13559 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161465AbWBUKiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:38:13 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 21 Feb 2006 11:36:18 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: nix@esperi.org.uk, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, davidsen@tmr.com, chris@gnome-de.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43FAED22.nailD1291Q4HS@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <200602192053.25767.dhazelton@enter.net>
 <43F9F11E.nail5BM21M01Q@burner>
 <200602202311.29759.dhazelton@enter.net>
In-Reply-To: <200602202311.29759.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> Joerg, I've been thinking about your report about Linux munging CDB's sent to 
> certian ATAPI devices. While reading the MMC-5 spec again today (my memory of 
> it was starting to fail and I felt I had best be on top of it in this 
> discussion) a statement made about sending SCSI commands to ATAPI devices 
> caught me.
>
> ATAPI command packets are fixed at a 12 byte size. Is it possible you tried to 
> send a CDB in excess of that fixed size re: those drives that get a munged 
> CDB?

I did write some time ago that the most probable cause for the Linux bug is that
Linux is sending uninitialized data for the amount of bytes that pad to 12 byte.

Libscg is the first application ever, that always correctly deals with CDB size
as it started to do so in August 1986 which is before any other SCSI generic 
transport has been available.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
