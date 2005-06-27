Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVF0Jmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVF0Jmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVF0Jmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:42:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33171 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261993AbVF0Jmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:42:31 -0400
Date: Mon, 27 Jun 2005 10:42:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Zarochentsev <zam@namesys.com>
Cc: David Masover <ninja@slaphack.com>, Jeff Garzik <jgarzik@pobox.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050627094223.GB5470@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Zarochentsev <zam@namesys.com>,
	David Masover <ninja@slaphack.com>, Jeff Garzik <jgarzik@pobox.com>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org> <42B92AA1.3010107@slaphack.com> <20050626170203.GC18942@infradead.org> <200506271330.07451.zam@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506271330.07451.zam@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 01:30:06PM +0400, Alexander Zarochentsev wrote:
> -- procfs  has seq_file and sysconfig interfaces below the VFS and l-k people 
> do not complain each day about layering violation ;-)  Procfs is taken as an 
> example because it deals with objects of different types, actually anybody 
> may create own procfs objects more or less general way.

seq_file actually works at the file_operations level, that's exactly
what I'm telling you to do.  The old sub-callbacks are on their way out.

> I don't belive that you want to see all reiser4-specific things as item 
> plugins, disk format plugins in the VFS.

If you'd read the previous discussions you'd see that no one complained
about disk format plugins.

