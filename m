Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVA3Xjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVA3Xjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVA3Xjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:39:40 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:30645 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261876AbVA3XjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:39:22 -0500
Date: Mon, 31 Jan 2005 00:36:02 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
In-Reply-To: <20050130231055.GA7103@stusta.de>
Message-ID: <Pine.LNX.4.61.0501310025360.6118@scrub.home>
References: <9dda349205012923347bc6a456@mail.gmail.com>
 <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org>
 <20050130105738.GA28387@infradead.org> <20050130120009.GG3185@stusta.de>
 <20050130121241.GH3185@stusta.de> <Pine.LNX.4.61.0501302358270.6118@scrub.home>
 <20050130231055.GA7103@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Jan 2005, Adrian Bunk wrote:

> WANT_EXPORTFS gets selected by NFSD.
> 
> EXPORTFS is usually WANT_EXPORTFS, but if WANT_EXPORTFS=m and 
> XFS_WANT_EXPORT=y, then EXPORTFS=y.
> 
> Since XFS_WANT_EXPORT itself depends on WANT_EXPORTFS this was my 
> workaround to avoid a circular dependency.

Why not just let XFS_FS select EXPORTFS directly:

config XFS_FS
	select EXPORTFS if NFSD

bye, Roman
