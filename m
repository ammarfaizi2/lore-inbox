Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVHJQ13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVHJQ13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbVHJQ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:27:28 -0400
Received: from mxsf10.cluster1.charter.net ([209.225.28.210]:33685 "EHLO
	mxsf10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965189AbVHJQ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:27:27 -0400
X-IronPort-AV: i="3.96,97,1122868800"; 
   d="scan'208"; a="1424047886:sNHT15746624"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17146.10987.646530.492808@smtp.charter.net>
Date: Wed, 10 Aug 2005 12:27:23 -0400
From: "John Stoffel" <john@stoffel.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: John Stoffel <john@stoffel.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <1123688778.5134.3.camel@mulgrave>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	<200508081954.52638.jesper.juhl@gmail.com>
	<17145.1417.329260.524528@smtp.charter.net>
	<1123617516.5170.42.camel@mulgrave>
	<17145.3629.933024.963438@smtp.charter.net>
	<1123635010.5170.75.camel@mulgrave>
	<17146.7454.818003.464185@smtp.charter.net>
	<1123688778.5134.3.camel@mulgrave>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James> Well, I suspect the tape is hanging the bus, from which no card
James> can recover.

Blech, not going to be fun to fix this sucker.

James> Just to test this, can you try sending a bus reset with sgutils (from
James> the debain package sg3-utils):

James> sg_reset -b /dev/sg3

James> Then remove and re-add the device with

James> echo scsi remove-single-device 1 0 6 0 > /proc/scsi/scsi
James> echo scsi add-single-device 1 0 6 0 > /proc/scsi/scsi

James> And see if that brings it back.  If it doesn't I'm afraid the
James> tape has the bus locked and nothing can free it.

It didn't bring it back, but I'm also not at home to look at the
device either.  Bummers.  I'll play around with this some more and get
back to people when I can.

Should I be moving back to 2.6.13-rc6 to get the speedup on /dev/sda
anyway?  Since my OS partitions are on SCSI.
