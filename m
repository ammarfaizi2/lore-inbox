Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVHaNal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVHaNal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVHaNal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:30:41 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:39043 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964798AbVHaNal convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:30:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SSKD78xawAXIc52jtGSHovjatvf5BlcUi/R3AHb5h09UC5p93kicH7V5bc35AXMzgHMcK4s6MLmOjcSG/3ikP8d7DYpxPogUUTdHTJ2lMRQeCYCMOUGRAYr7OHHZJO9jlpoZ/9lci3KTbH8UVT3CQI4uD0241YT7/VNJYydtceA=
Message-ID: <3afbacad0508310630797f397d@mail.gmail.com>
Date: Wed, 31 Aug 2005 15:30:37 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: aoe fails on sparc64
Cc: ecashin@coraid.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Using aoe on a sparc64 system gives strange results:

sunny:/dev/etherd# echo >discover
sunny:/dev/etherd# mke2fs e0.0
mke2fs 1.37 (21-Mar-2005)
mke2fs: File too large while trying to determine filesystem size
sunny:/dev/etherd# blockdev --getsz e0.0
-4503599627370496

The log says:

Aug 31 15:18:49 sunny kernel: devfs_mk_dir: invalid argument.<6>
etherd/e0.0: unknown partition table
Aug 31 15:18:49 sunny kernel: aoe: 0011d8xxxxxx e0.0 v4000 has
67553994410557440
sectors

The system is an Sun Ultra 5, running 2.6.12.5/sparc64 compiled with
gcc-3.4.2.  e0.0 is exported on a x86 system using vblade-5, and has a
size of 30 MB.

Regards,
Jim
