Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132603AbRBRFbE>; Sun, 18 Feb 2001 00:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132643AbRBRFaz>; Sun, 18 Feb 2001 00:30:55 -0500
Received: from 64-32-144-137.nyc1.phoenixdsl.net ([64.32.144.137]:12806 "HELO
	mail.ovits.net") by vger.kernel.org with SMTP id <S132603AbRBRFak>;
	Sun, 18 Feb 2001 00:30:40 -0500
Date: Sun, 18 Feb 2001 00:31:26 -0500
From: Mordechai Ovits <movits@ovits.net>
To: Andre Tomt <andre@tomt.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 crashing every other day
Message-ID: <20010218003125.A25564@ovits.net>
In-Reply-To: <OPECLOJPBIHLFIBNOMGBOEGFDBAA.andre@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <OPECLOJPBIHLFIBNOMGBOEGFDBAA.andre@tomt.net>; from andre@tomt.net on Sun, Feb 18, 2001 at 02:46:30AM +0100
X-Satellite-Tracking: 0x4B305AFF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2001 at 02:46:30AM +0100, Andre Tomt wrote:
> Very recently I installed a new mailserver for my company, based around
> qmail, linux 2.4.1, and software raid 1.
> It works very nicely untill it spews out oops's after a few days, leaving
> hundreds of qmail-popup processes hanging, unkillable. THe server is very
> lightly loaded for now, doing only a few hundreds smtp + pop's a day.
> 
> It's a Pentium III 733 based system, with 256MB RAM (one stick, we have
> already tried another stick), and every partition except swap on software
> RAID 1. Both IDE disks (IBM-DTLA-307030, 30GB each) are connected to a HPT
> ATA100 IDE controller (see the lscpi-output). I've attached some info, and
> one decoded oops. Longer down you'll find info from lspci and the like.
> 
> As a side note, we have one other _identical_ hardware setup, running the
> same kernel, same base software, same partitioning, same RAID setup, just as
> a webserver. And it works grrrreat, no hickups whatsoever. Also, the oops's
> seems to happen only with qmail-popup, at least thats how the few crashes I
> had the chance to investigate did.
> 

Looks like you were bitten by either the RAID 1 bugs or the elevator bugs.
Try a 2.4.2-pre4 or an 2.4.1-ac18 kernel.  Should solve it.

Mordy
