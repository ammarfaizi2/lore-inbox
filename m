Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSFGNej>; Fri, 7 Jun 2002 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSFGNei>; Fri, 7 Jun 2002 09:34:38 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:12297 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S317282AbSFGNei>; Fri, 7 Jun 2002 09:34:38 -0400
Message-ID: <64655AAA92E6ED46B9AC9421260D96A5D18BF4@srmanning.eng.emc.com>
From: "goggin, edward" <egoggin@emc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Request to have get_blkfops() and get_chrfops() exported to kerne
	l modules
Date: Fri, 7 Jun 2002 09:33:41 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a request to have both the linux kernel symbols
get_chrfops and get_blkfops exported to kernel modules
in future releases of the linux kernel.

This request is in response to a need we have when building
kernel modules which will filter block and/or character device
i/o by trapping the native block/character i/o requests.

We propose three source modifications as part of this request.
Furthermore, assuming approval of this request, we will supply
a source patch to effect these modifications.

	1)	EXPORT_SYMBOL references for both get_charfops and
		get_blkfops be placed in fs/devices.c.

	2)	Removal of the static scope qualifier for the 
		definition of get_chrfops() in fs/devices.c.

	3)	The file devices.o be added to the list of exported
		in fs/Makefile.

Ed Goggin
