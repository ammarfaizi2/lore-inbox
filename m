Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVLOMW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVLOMW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVLOMW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:22:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14220 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965188AbVLOMW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:22:57 -0500
Date: Thu, 15 Dec 2005 12:22:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH 1/3] m68k: compile fix - hardirq checks were in wrong place
Message-ID: <20051215122252.GA23407@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20051215085402.GT27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151252110.1605@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512151252110.1605@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You separate the definition from the check, now you push the 
> responsibility to get the order right to the header users.
> Sorry, but I prefer to fix the header dependencies than scatter things 
> which belong together over multiple files.

For 2.6.16 I'll submit a patch to merge asm/irq.h and asm/hardirq.h.
Until then this is the much better fix because it doesn't require
pointless include reordering all over the tree.
