Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263840AbUEGXJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUEGXJB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUEGXJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 19:09:01 -0400
Received: from ivry-1-81-57-179-44.fbx.proxad.net ([81.57.179.44]:34568 "EHLO
	ivry-1-81-57-179-44.fbx.proxad.net") by vger.kernel.org with ESMTP
	id S263840AbUEGXIs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 19:08:48 -0400
From: =?iso-8859-1?q?C=E9dric_Rivard?= <cedric@rivard.info>
To: Heilmann@cdj.yemanja.net, Oliver <Oliver.Heilmann@drkw.com>
Subject: Re: [PATCH] SIS AGP vs 2.6.6-rc2
Date: Sat, 8 May 2004 01:08:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405080108.43694.cedric@rivard.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heilmann, Oliver wrote:

> Basically, if you have an  SiS chipset and your machine freezes when you
> start X, try the -agp_sis_force_delay=1 option. If this fixes your
> problem add your PCI ID to sis_broken_chipsets in sis-agp.c
> Note to 746[FX] people: I'm still not sure what the differences between
> the two 746 versions and the 648 series are. If this patch does not work
> for you try playing with the agp_sis_agp_spec module option. Any
> feedback is greatly appreciated.

Hi Oliver,

SIS 655 does also require the delay workaround not to freeze.
Following, the relevant kernel log of my machine (SIS655TX with Radeon 9200):

cdj:~# dmesg |grep -i agp
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 655 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xe0000000
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: SiS delay workaround: giving bridge time to recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode


Cheers,
Cédric Rivard
