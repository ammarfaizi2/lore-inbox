Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWCHV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWCHV2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWCHV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:28:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932424AbWCHV2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:28:19 -0500
Date: Wed, 8 Mar 2006 21:28:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, rminnich@lanl.gov, lucho@ionkov.net, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] 9p: Fix error handling on superblock alloc failure [try #7]
Message-ID: <20060308212812.GB8042@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, akpm@osdl.org,
	rminnich@lanl.gov, lucho@ionkov.net, ericvh@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com> <20060308203021.25493.85005.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308203021.25493.85005.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 08:30:21PM +0000, David Howells wrote:
> The attached patch adds error handling and cleanup in the case that sget()
> fails, lest a memory leak occur.

this is a small and simple fix that should go into 2.6.16 after the 9p
maintainers ACKed it.  Of course that means redoing it to apply before the
get_sb prototype change.
