Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUEWXDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUEWXDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUEWXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:03:30 -0400
Received: from canuck.infradead.org ([205.233.217.7]:61962 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263713AbUEWXD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:03:29 -0400
Date: Sun, 23 May 2004 19:03:11 -0400
From: hch@infradead.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export swapper_space
Message-ID: <20040523230311.GA7194@infradead.org>
Mail-Followup-To: hch@infradead.org,
	James Bottomley <James.Bottomley@steeleye.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1085352637.10930.42.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085352637.10930.42.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 05:50:36PM -0500, James Bottomley wrote:
> This is now used as part of the page_mapping() macro.  However, certain
> filesystems, such as ext3, make use of this.  If it's not exported, they
> can't be compiled as modules.

A filesystem (except for tmpfs of course) using page_mapping() looks
like a bug to me.   I can't find ext3 using it anyway..

