Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSJONvJ>; Tue, 15 Oct 2002 09:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJONvJ>; Tue, 15 Oct 2002 09:51:09 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:11780 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262780AbSJONvI>; Tue, 15 Oct 2002 09:51:08 -0400
Date: Tue, 15 Oct 2002 15:56:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel conf 0.9
In-Reply-To: <Pine.NEB.4.44.0210151528310.20607-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210151550340.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Oct 2002, Adrian Bunk wrote:

> recursive dependency: ISDN_DRV_EICON_DIVAS ISDN_DRV_EICON_OLD (choice(2) detected) ISDN_DRV_EICON_DIVAS
> recursive dependency: AEDSP16_MSS AEDSP16_SBPRO (choice(1) detected) AEDSP16_MSS
> recursive dependency: INPUT_GAMEPORT INPUT_GAMEPORT
> recursive dependency: SCSI_AIC7XXX_OLD SCSI_AIC7XXX (choice(2) detected) SCSI_AIC7XXX_OLD AIC7XXX_BUILD_FIRMWARE
> Segmentation fault
> $

You either have to apply the prepare patch or manually remove the
CONFIG_INPUT_GAMEPORT definitions from the config files.
The converter cannot handle unresolved recursive dependencies, this is
fixable, but on the other hand also easy to avoid, so I didn't bother.

bye, Roman

