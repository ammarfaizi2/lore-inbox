Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUCVSXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUCVSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:23:34 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:31963 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S262176AbUCVSXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:23:30 -0500
Date: Mon, 22 Mar 2004 18:23:28 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322182328.GH17627@malvern.uk.w2k.superh.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz> <20040320160911.B6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz> <20040320222341.J6726@flint.arm.linux.org.uk> <20040320224518.GQ2045@holomorphy.com> <20040320235445.B24744@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403201920560.28447@montezuma.fsmlabs.com> <1079930812.900.180.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079930812.900.180.camel@gaston>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 22 Mar 2004 18:25:07.0968 (UTC) FILETIME=[0108B800:01C4103B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2004-03-22]:
> DRI suffers from similar issue when using PCI GART, but then, it also
> doesn't use the consistent alloc routines, it gets pages with GFP,
> mmap those into userland, and does pci_map_single in the kernel on
> each individual page to obtain the bus addresses. This will not be
> pretty on non-coherent architectures though.

... or on platforms where PCI bounce-buffers are being used.

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
