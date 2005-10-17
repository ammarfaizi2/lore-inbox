Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVJQLgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVJQLgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVJQLgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:36:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751237AbVJQLgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:36:08 -0400
Date: Mon, 17 Oct 2005 12:36:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robin Holt <holt@sgi.com>
Cc: Greg KH <greg@kroah.com>, linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com, Dave Hansen <haveblue@us.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051017113601.GA25434@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robin Holt <holt@sgi.com>, Greg KH <greg@kroah.com>,
	linux-ia64@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com, wli@holomorphy.com,
	Dave Hansen <haveblue@us.ibm.com>,
	Jack Steiner <steiner@americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com> <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com> <20051017113131.GA30898@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017113131.GA30898@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 06:31:31AM -0500, Robin Holt wrote:
> On Fri, Oct 14, 2005 at 02:30:38PM -0700, Greg KH wrote:
> > On Fri, Oct 14, 2005 at 02:22:25PM -0500, Robin Holt wrote:
> > > +EXPORT_SYMBOL(get_one_pte_map);
> > 
> > EXPORT_SYMBOL_GPL() ?
> 
> Not sure why it would fall that way.  Looking at the directory,
> I get:

This is a very lowlevel export for things that poke deep into VM
internals, so _GPL makes sense.  In fact not allowing modular builds
of the mspec driver might make even more sense.

