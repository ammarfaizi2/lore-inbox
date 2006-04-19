Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDSQ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDSQ5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWDSQ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:57:08 -0400
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:35337 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1750815AbWDSQ5G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:57:06 -0400
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: sata suspend resume ...
Date: Wed, 19 Apr 2006 18:56:15 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604191856.16026.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 18:13, Hugh Dickins wrote:
> On Wed, 19 Apr 2006, Jeff Chua wrote:
> > Any change of getting suspend/resume to work on my IBM X60s notebook.
> >
> > Disk model is ...
> >
> > 	MODEL="ATA HTS541060G9SA00"
> > 	FW_REV="MB3I"
> >
> > Linux 2.6.17-rc2.
> >
> > System suspends ok. Resume ok. but no disk access after that.
>
> Not the same disk model, but I've been having similar trouble on a T43p.
>
> I was delighted to see the MSI suspend/resume fix go into 2.6.17-rc2,
> but then disappointed. 

Are you using ahci or ata_piix? It seem that people have success with AHCI but 
not with ata_piix. 

My ThinkPad Z60m has
00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 
03)
which afaik is AHCI capable but only if BIOS initializes it in ahci mode ;-/
Unfortunately there is no such option in BIOS (I've checked latest available 
bios - 1.14).

Is it possible to initialize this controller in AHCI mode by Linux itself 
without BIOS help? (where possible means ,,possible but not implemented'', 
too)

> Hugh

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
