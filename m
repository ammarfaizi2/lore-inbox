Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTEMRAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTEMRAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:00:01 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:34053 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262378AbTEMRAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:00:00 -0400
Subject: Re: 2.6 must-fix list, v2
From: James Bottomley <James.Bottomley@steeleye.com>
To: akpm@diego.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 May 2003 12:12:32 -0500
Message-Id: <1052845953.6663.23.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For SCSI, as far as the basics go we still have

Need to convert to DMA-mapping:

	am53c974 dpt_i2o initio pci2220i

Don't compile currently:

	inia100 cpqfc pci2000 dc390t

Need converting to the new eh:

	wd33c99 based: a2091 a3000 gpv11 mvme174 sgiwd93 
	53c7xx based: amiga7xxx bvme6000 mvme16x
	initio am53c974 pci2000 pci2220i qla1280 sym53c8xx dc390t

I think the sym53c8xx could probably be pulled out of the tree because
the sym_2 replaces it.  I'm also looking at converting the qla1280.

It also might be possible to shift the 53c7xx based drivers over to
53c700 which does the new EH stuff, but I don't have the hardware to
check such a shift.

For the non-compiling stuff, I've probably missed a few that just aren't
compilable on my platforms, so any updates would be welcome.  Also, are
some of our non-compiling or unconverted drivers obsolete?

James


