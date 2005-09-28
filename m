Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVI1MzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVI1MzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVI1MzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:55:12 -0400
Received: from c3po.0xdef.net ([217.172.181.57]:61611 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S1751270AbVI1MzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:55:10 -0400
Date: Wed, 28 Sep 2005 14:55:09 +0200
From: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 128 kbytes allocation limit for kmalloc?
Message-ID: <20050928125509.GA28656@0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>,
	linux-kernel@vger.kernel.org
References: <20050927174032.GA26236@archivum.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050927174032.GA26236@archivum.info>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* mailarch@archivum.info | 2005-09-27 19:40:32 [+0200]:

>Hello,
>
>is it possible to allocate more than 128 kbytes in a kernel lkm module?

Yes, multiple kmalloc calls. You can implement your own memory managment
in top of it. For further informations: cat /proc/slabinfo

>When I allocate more than 128 kbytes with the kmalloc call, kmalloc returns NULL.

If you need one continues chunk of memory you must take vmalloc. But
note the performance penalty and some other disadvantages (dma, ...).

HGN

-- 
Standards are industry's way of codifying obsolescence.
