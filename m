Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSFQXyd>; Mon, 17 Jun 2002 19:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317171AbSFQXyc>; Mon, 17 Jun 2002 19:54:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3514 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317170AbSFQXyc>;
	Mon, 17 Jun 2002 19:54:32 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 18 Jun 2002 01:53:56 +0200 (MEST)
Message-Id: <UTC200206172353.g5HNruB26549.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, martin.schwidefsky@debitel.net
Subject: Re: [PATCH] 2.5.22: ibm partition support.
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we talked about IBM partitions before, but I forgot all
about them. Wonder why this strange convoluted code is necessary.
For example, I am worried a little by your need to call HDIO_GETGEO.
For IDE and SCSI disks, the geometry that is returned
depends on the phase of the moon and similar things.
But maybe you use it only for dasd* disks?
Is there a bug in dasd_eckd_fill_geometry()?
It seems that it sometimes fails to set geo->sectors,
but you use geo->sectors in cchh2blk() and family.

Andries
