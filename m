Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270359AbUJTNXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270359AbUJTNXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270357AbUJTNQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:16:55 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:9481 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270009AbUJTNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:10:18 -0400
Date: Wed, 20 Oct 2004 14:10:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Amit Gud <amitgud1@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Remove union u from linux/fs.h
Message-ID: <20041020131015.GB20287@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <2c59f00304102002135ca68dd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c59f00304102002135ca68dd0@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 02:43:59PM +0530, Amit Gud wrote:
> Do we need the foolish-looking union with just single entry (void
> *generic_ip) in the struct inode linux/fs.h anymore? Why not remove
> it?
> 
> This patch does that along with the changes in other parts of the
> kernel that references the union. Its compile-tested and applies
> cleanly to 2.6.9 vanilla.

I don't think we shoould do such purely cosmetic changes that break backwards
compatibility during stable series.

