Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWBYPNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWBYPNV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWBYPNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:13:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:45966 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030266AbWBYPNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:13:20 -0500
X-Authenticated: #428038
Date: Sat, 25 Feb 2006 16:13:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [libata] CD on PATA: "ReadCD MMC 12"  command fails
Message-ID: <20060225151315.GA21887@merlin.emma.line.org>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20060224074310.GA1311@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224074310.GA1311@pc11.op.pod.cz>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, =?ISO-8859-2?Q?V=EDt=ECzslav?= Samel wrote:

>   I'm trying to rip some music CD with cdda2wav, but that fails. I have "LG
> GSA-4165B" (PATA drive) connected on 8086:24db (Intel ICH5 IDE controller)
> using ata_piix.
> 
> cdda2wav first fails with ENOMEM (16 times) and then with EDOM till the end of
> the track in response to the "ReadCD MMC 12" (code 0xbe) SG_IO command (see
> attached output and strace). Ripping on plain SCSI CD drive works OK.
> 
> Tested on 2.6.16-rc4 and alans 2.6.16-rc4-ide2. I also applied your fix
> mailed to LKML on Tue, 21 Feb 2006 00:17:14 -0500.

Is cdda2wav installed setuid-root? If so, try removing that flag and
running cdda2wav with sudo. The ENOMEM might be related to libscg
making bogus assumptions about mlockall().

-- 
Matthias Andree
