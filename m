Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVC1URd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVC1URd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVC1URd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:17:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262056AbVC1URc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:17:32 -0500
Date: Mon, 28 Mar 2005 21:17:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: namei operations should pass nameidata when available
Message-ID: <20050328201728.GA12668@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Mahoney <jeffm@suse.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050328200617.GA13280@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328200617.GA13280@locomotive.unixthugs.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	dentry = __lookup_hash(&nd->last, nd->dentry, nd);

Please add a tiny wrapper lookup_hash_nd(struct nameidata *nd)
that expands to the above instead of opencoding it everywhere.

Or just call it lookup_hash() after you removed the original version..
