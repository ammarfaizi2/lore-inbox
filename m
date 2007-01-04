Return-Path: <linux-kernel-owner+w=401wt.eu-S932379AbXADPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbXADPxl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbXADPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:53:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56692 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbXADPxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:53:40 -0500
Date: Thu, 4 Jan 2007 15:52:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Adrian Bunk <bunk@stusta.de>, Nick Piggin <npiggin@suse.de>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [2.6 patch] the scheduled find_trylock_page() removal
Message-ID: <20070104155238.GA5648@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Adrian Bunk <bunk@stusta.de>,
	Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org,
	Linux Memory Management <linux-mm@kvack.org>
References: <20070102215735.GD20714@stusta.de> <459C8833.7080500@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C8833.7080500@yahoo.com.au>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 03:53:07PM +1100, Nick Piggin wrote:
> Adrian Bunk wrote:
> >This patch contains the scheduled find_trylock_page() removal.
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I guess I don't have a problem with this going into -mm and making its way
> upstream sometime after the next release.
> 
> I would normally say it is OK to stay for another year because it is so
> unintrusive, but I don't like the fact it doesn't give one an explicit ref
> on the page -- it could be misused slightly more easily than find_lock_page
> or find_get_page.
> 
> Anyone object? Otherwise:

Just kill it.  There's absolutely no point in keeping dead code around.
It's bad enough we keep such things around for half a year.

