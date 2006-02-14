Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWBNMXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWBNMXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWBNMXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:23:37 -0500
Received: from mail.gmx.net ([213.165.64.21]:50151 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161033AbWBNMXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:23:36 -0500
X-Authenticated: #428038
Date: Tue, 14 Feb 2006 13:23:33 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214122333.GA32743@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <43F0A010.nailKUSR1CGG5@burner> <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com> <43F0AA83.nailKUS171HI4B@burner> <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com> <43F0B2BA.nailKUS1DNTEHA@burner> <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr> <43F0B5BE.nailMBX2SZNBE@burner> <200602131919.k1DJJF5G025923@turing-police.cc.vt.edu> <43F1C385.nailMWZ599SQ5@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F1C385.nailMWZ599SQ5@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-14:

> -	How does HAL allow one cdrecord instance to work
> 	without being interrupted by HAL?

That is not the duty of an external system such as HAL and its daemons,
hald*.

There is ongoing research WRT HAL interruptions, and the final word on
HAL, O_EXCL and everything has not yet been spoken IMO.

Indulge yourself, I'm quite sure this will have been sorted out before
Equinoxe.

> -	How to send non disturbing SCSI commands from another
> 	cdrecord process in case one or more are already running?

Open the device node you obtained and
send non-disturbing commands through it.

No special treatment required.

-- 
Matthias Andree
