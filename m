Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWBMUNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWBMUNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWBMUNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:13:51 -0500
Received: from mail.gmx.de ([213.165.64.21]:62108 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964848AbWBMUNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:13:50 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 21:13:46 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213201346.GA24811@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43F097AE.nailKUSK1MJ9O@burner> <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE> <20060213095038.03247484.seanlkml@sympatico.ca> <43F0A771.nailKUS131LLIA@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner> <mj+md-20060213.164948.25807.atrey@ucw.cz> <43F0BA53.nailMDD11T4U8@burner> <mj+md-20060213.171329.3029.atrey@ucw.cz> <43F0C19C.nailMDR1O1BOX@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0C19C.nailMDR1O1BOX@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> The warnings are not silly. They could have been removed long ago
> if the icd-scsi DMA bug was fixed.

The warnings are way off track, because

1. /dev/hd* means ide-cd which has never had the incriminated bugs,
   no matter if badly designed or not

2. you can't tell from looking at /dev/sg* or the b,t,l if the device
   node is operated by the ide-scsi or sg drivers. Both use the unified
   /dev/sg* namespace.

In fact, it makes sense to suppress the warning for /dev/hd* and ATA:
which are known good.

-- 
Matthias Andree
