Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUI2PGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUI2PGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUI2PFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:05:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:40452 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268588AbUI2PBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:01:45 -0400
Date: Wed, 29 Sep 2004 16:01:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: get_user_pages() still broken in 2.6
Message-ID: <20040929160134.A13683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Timur Tabi <timur.tabi@ammasso.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <4159E85A.6080806@ammasso.com> <20040929000325.A6758@infradead.org> <415ACB29.5000104@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <415ACB29.5000104@ammasso.com>; from timur.tabi@ammasso.com on Wed, Sep 29, 2004 at 09:48:09AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 09:48:09AM -0500, Timur Tabi wrote:
> Christoph Hellwig wrote:
> 
> > get_user_pages locks the page in memory.  It doesn't do anything about ptes.
> 
> I don't understand the difference.  I thought a locked page is one that 
> stays in memory (i.e. isn't swapped out) and whose physical address 
> never changes.  Is that wrong?

Yes.  But if you're walking ptes you're looking at virtual addresses
somehow.  Can you send me a pointer to your code please?  I suspect
it's doing something terribly stupid.

