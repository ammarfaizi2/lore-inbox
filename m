Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161467AbWBUKiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbWBUKiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWBUKiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:38:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161467AbWBUKiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:38:13 -0500
Date: Tue, 21 Feb 2006 10:38:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport install_page
Message-ID: <20060221103808.GB19349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060220223709.GT4661@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220223709.GT4661@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 11:37:09PM +0100, Adrian Bunk wrote:
> No in-kernel module is using it, so there's no reason bloating the 
> kernel with this EXPORT_SYMBOL.

And no one should be using it, really.  It's a helper for sys_remap_file_pages
implementations, something that nothing but the generic filemap.c or
shmem.c should do.

