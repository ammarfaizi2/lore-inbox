Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSHBCUv>; Thu, 1 Aug 2002 22:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSHBCUv>; Thu, 1 Aug 2002 22:20:51 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:3826 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317708AbSHBCUv>; Thu, 1 Aug 2002 22:20:51 -0400
Date: Thu, 01 Aug 2002 21:47:28 -0400
From: Nick Orlov <nick.orlov@mail.ru>
Subject: [PATCH] pdc20265 problem.
In-reply-to: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
To: lkml <linux-kernel@vger.kernel.org>
Mail-followup-to: lkml <linux-kernel@vger.kernel.org>
Message-id: <20020802014728.GA796@nikolas.hn.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_SJK+ke6N+0T84slayxW2Hg)"
User-Agent: Mutt/1.4i
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_SJK+ke6N+0T84slayxW2Hg)
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline


> <marcelo@plucky.distro.conectiva> (02/07/19 1.646)
> 	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak

Because of this fix my Promise 20265 became ide0 instead of ide2.
Is there any reason to mark pdc20265 as ON_BOARD controller?

Anyway, attached patch fix it for me :)

-- 
With best wishes,
	Nick Orlov.


--Boundary_(ID_SJK+ke6N+0T84slayxW2Hg)
Content-type: text/plain; charset=koi8-r; NAME=pcd20265.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=pcd20265.patch

408c408
<         {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
---
>         {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },

--Boundary_(ID_SJK+ke6N+0T84slayxW2Hg)--
