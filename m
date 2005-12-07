Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbVLGXSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVLGXSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVLGXSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:18:18 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:14519 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030433AbVLGXSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:18:18 -0500
Subject: Re: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of
	remap_pfn_range()
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Holloway <Nick.Holloway@pyrites.org.uk>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0512061801220.26899@goblin.wat.veritas.com>
References: <20051205152758.GA29108@pyrites.org.uk>
	 <Pine.LNX.4.61.0512061801220.26899@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 07 Dec 2005 21:03:24 -0200
Message-Id: <1133996604.7047.83.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2005-12-06 às 18:31 +0000, Hugh Dickins escreveu:
> On Mon, 5 Dec 2005, Nick Holloway wrote:
> 

> Mauro, is this drivers/media/video/cpia.c under your maintainership?
> If the maintainer wants such a patch to go in now, then I'd agree
> with him; but I wouldn't be pushing it myself.
	Good question... yes and no... v4l subsystem is under my concern, but I
never touched this driver. Also, it doesn't use videodev.c. Maybe we
should address this question to v4l mailing list (I'm c/c).


	Your comments seems to be pertinent, IMHO. Btw, we have also a similar
patch for em28xx driver at our quilt tree:
	http://linuxtv.org/downloads/quilt

	under:

patches/v4l_dvb_3113_convert_em28xx_to_use_vm_insert_page_instead_of_remap_pfn_range.patch

	Would you please review it also? I've tested it and it seems to work
properly.

Cheers, 
Mauro.

