Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVF0TZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVF0TZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVF0TZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:25:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34719 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261754AbVF0TWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:22:45 -0400
Date: Mon, 27 Jun 2005 20:22:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Zarochentsev <zam@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, reiserfs-list@namesys.com,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20050627192243.GA21932@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Zarochentsev <zam@namesys.com>, reiserfs-list@namesys.com,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <200506271330.07451.zam@namesys.com> <20050627094223.GB5470@infradead.org> <200506271528.49674.zam@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506271528.49674.zam@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:28:49PM +0400, Alexander Zarochentsev wrote:
> not exactly.  I meant that seq_file has its own VFS-like thing struct 
> seq_operations.

It's not that VFS-like, it's more a set of callback than actual methods.
But yes, if you're actually doing work at a significant lower layer
adding abstractions make sense.  Note that seq_file.c while not beeing
the VFS is also a generic library that you can use with any filesystem
if you want to implement sequential synthetic files.

