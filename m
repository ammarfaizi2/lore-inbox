Return-Path: <linux-kernel-owner+w=401wt.eu-S965110AbXAJVVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbXAJVVd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbXAJVVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:21:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36964 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965110AbXAJVVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:21:07 -0500
Date: Wed, 10 Jan 2007 21:21:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       esandeen@redhat.com, aviro@redhat.com
Subject: Re: [PATCH 1/3] make static counters in new_inode and iunique be 32 bits
Message-ID: <20070110212103.GA4425@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, esandeen@redhat.com, aviro@redhat.com
References: <200701082047.l08Kl7mh001917@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701082047.l08Kl7mh001917@dantu.rdu.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 03:47:07PM -0500, Jeff Layton wrote:
> When a 32-bit program that was not compiled with large file offsets does a
> stat and gets a st_ino value back that won't fit in the 32 bit field, glibc
> (correctly) generates an EOVERFLOW error. We can't do anything about fs's
> with larger permanent inode numbers, but when we generate them on the fly,
> we ought to try and have them fit within a 32 bit field.
> 
> This patch takes the first step toward this by making the static counters in
> these two functions be 32 bits.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Ok.
