Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTKKMuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 07:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTKKMuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 07:50:51 -0500
Received: from main.gmane.org ([80.91.224.249]:57506 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263488AbTKKMuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 07:50:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Re: 2.4 ICH4 + SATA bridge problems
Date: 11 Nov 2003 12:34:41 GMT
Organization: none
Message-ID: <boql11$qps$1%proserpine.haus@yggdrasl.demon.co.uk>
References: <20031107013554.72178e8e.rumi_ml@rtfm.hu>
X-Complaints-To: usenet@sea.gmane.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a futile gesture against entropy, Rumi Szabolcs wrote:

> I have tested this with two different drives, a fully native
> SATA drive (ST3160023AS) and a pseudo-SATA drive (MX6Y120M0)
> which uses the same Marvell chip internally to convert SATA
> back to PATA because thats what the drive really is. The
> result is that both drives show up as UDMA100 in the BIOS
> and as UDMA33 in the kernel.

IIRC this is due to a problem with the cable-detection code in 2.4.22 -
it looks for an 80-conductor cable (which SATA certainly doesn't have!)
and sensibly refuses to enable modes above UDMA2 if one is not present.

I believe this is fixed in 2.4.23-pre, so the best answer is probably
either to install the latest of those or to wait for .23-final to
appear.  (I have the same issue; I've opted for the latter.)
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("sudden vision of a klein pizza"                                   )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

