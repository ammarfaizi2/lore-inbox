Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753490AbWKCT0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbWKCT0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbWKCT0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:26:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28057 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753490AbWKCT0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:26:06 -0500
Subject: Re: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luugi Marsan <luugi.marsan@amd.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061103185420.B3FA6CBD48@localhost.localdomain>
References: <20061103185420.B3FA6CBD48@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Nov 2006 19:30:16 +0000
Message-Id: <1162582216.12810.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-11-03 am 13:54 -0500, ysgrifennodd Luugi Marsan:
> From: conke.hu@amd.com
> 
> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID.IDE modes are used for compatibility with some old OS without AHCI driver,but now they are not necessary for Linux since the kernel has supported AHCI.Some BIOS set Legacy IDE as SB600 SATA's default mode, but the AHCI driver cannot run in Legacy IDE.So, we should set the controller back to AHCI mode if it has been set as IDE by BIOS.
> 
> Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>

NAK

This should only be done if AHCI is configured into the kernel, so wants
a #ifdef check adding. Otherwise people using SB600 via the legacy ide
layer will get burned.
