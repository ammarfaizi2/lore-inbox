Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265874AbUFYMsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUFYMsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFYMsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:48:15 -0400
Received: from [213.146.154.40] ([213.146.154.40]:4024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265874AbUFYMsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:48:11 -0400
Date: Fri, 25 Jun 2004 13:48:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040625124807.GA29937@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 07:46:28AM -0500, Erik Jacobson wrote:
> We don't really have an option here.  None of the distros I know of will
> currently work with dynamic minors for the console device.  If we only use
> dynamic minors, our driver will simply not work with most of the
> distributions.
> 
> I don't want a driver that will break our console - I want one that will
> make it work better.  Dynamic minors, at least today, will just break us.
> 
> Plus, as I said before, LANANA's web page states they don't accept
> submissions for the 2.6 kernel.  What are we to do?

Linus stance is there shouldn't be new static allocations for 2.6 (I disagree
with him, btw).  I still wonder why you need your own major for 2.6 but not
for 2.4.
