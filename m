Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVLNKdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVLNKdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVLNKdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:33:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40134 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932295AbVLNKdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:33:39 -0500
Subject: Re: No sound from CX23880 tuner w. 2.6.15-rc5
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: "P. Christeas" <p_christ@hol.gr>
Cc: kraxel@bytesex.org, lkml <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <200512122217.56616.p_christ@hol.gr>
References: <200512122217.56616.p_christ@hol.gr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 14 Dec 2005 08:33:27 -0200
Message-Id: <1134556407.23489.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.163.0.147 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.163.0.147 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chisteas,

	Please address this to me c/c to V4L mailing list, since I'm the
current maintainer of V4L.

Em Seg, 2005-12-12 às 22:17 +0200, P. Christeas escreveu:
> I upgraded from 2.6.13.2 to 2.6.15-rc5 last week. Unfortunately I can no 
> longer hear the sound from my tuner (analog tv).
> lspci -vv -s 02:05.0
> 02:05.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and 
> Audio Decoder (rev 05)
>         Subsystem: LeadTek Research Inc.: Unknown device 663b
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 
> Is that bug acknowledged? 
	It maybe related to bad boards descriptions, without including tda9887
inside.
> Any early hints before I start a regression test?
> Radio (w. gnomeradio) works OK on the card. I can also hear 'peaks' whenever I 
> change the tv channel.
	Please try to modprobe tda8887. Also send us a dmesg with debug options
turned on. What's your video and audio standard?
	
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Cheers, 
Mauro.

