Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWEITCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWEITCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEITCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:02:37 -0400
Received: from c3po.0xdef.net ([217.172.181.57]:18950 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S1750807AbWEITCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:02:36 -0400
Date: Tue, 9 May 2006 21:02:34 +0200
From: Hagen Paul Pfeifer <hagen@jauu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Elf loader question: who updates .rela.dyn entries for load_bias compensation?
Message-ID: <20060509190234.GA26436@c3po.0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hagen@jauu.net>,
	linux-kernel@vger.kernel.org
References: <200605050944.15440.jzb@aexorsyst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200605050944.15440.jzb@aexorsyst.com>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Z. Bohach | 2006-05-05 09:44:15 [-0700]:

>I'm porting Linux to a new architecture, and ran into an issue with
>the .rela.dyn entries not being adjusted to compensate for the load_bias
>of an ET_DYN shared executable:  in particular, this is the ld.so itself that
>doesn't get its .rela.dyn entries incremented by +load_bias.  This makes
>references from _GLOBAL_OFFSET_TABLE_ refer to the old compile-time
>vma addresses, which of course causes runtime  segfaults (appropriately
>enough) with ld.so.

This is an issue of the link-editor.

HGN



-- 
A computer is like an Old Testament god, with a lot of rules  and
no mercy. - Joseph Campbell
