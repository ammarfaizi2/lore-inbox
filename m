Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVBHX3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVBHX3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVBHX3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:29:43 -0500
Received: from hera.kernel.org ([209.128.68.125]:6322 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261688AbVBHX2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:28:24 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: EBDA Question
Date: Tue, 8 Feb 2005 23:28:05 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cubhu5$3jf$1@terminus.zytor.com>
References: <91888D455306F94EBD4D168954A9457C01297B87@nacos172.co.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107905285 3696 127.0.0.1 (8 Feb 2005 23:28:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 8 Feb 2005 23:28:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <91888D455306F94EBD4D168954A9457C01297B87@nacos172.co.lsil.com>
By author:    "Moore, Eric Dean" <Eric.Moore@lsil.com>
In newsgroup: linux.dev.kernel
>
> EBDA - Extended Bios Data Area
> 
> Does Linux and various boot loaders(lilo/grub/etc)
> having any restrictions on where and how big 
> memory allocated in EBDA is? Is this
> handled for 2.4/2.6 Kernels?
> 
> Reason I ask is we are considering having
> BIOS(for a SCSI HBA Controller) allocating
> memory in EBDA for Firmware use. 
> We are concerned whether Linux would be writing
> over this region of memory during the handoff
> of BIOS to scsi lower layer driver loading.
> 

In general, dropping the EBDA below 0x9a000 is probably a
bad idea.  Recent Linux kernels and boot loaders should handle it,
though.  Keep in mind that you might find yourself in serious trouble
if you then have, for example, a PXE stack layered on top of your SCSI
BIOS.

	-hpa

