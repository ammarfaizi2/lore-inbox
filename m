Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWAWIyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWAWIyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWAWIyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:54:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27839 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751409AbWAWIyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:54:10 -0500
Subject: Re: [rfc] split_page function to split higher order pages?
From: Arjan van de Ven <arjan@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <20060123084715.GA9241@osiris.boeblingen.de.ibm.com>
References: <20060121124053.GA911@wotan.suse.de>
	 <1137853024.23974.0.camel@laptopd505.fenrus.org>
	 <20060123054927.GA9960@wotan.suse.de>
	 <20060123084715.GA9241@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 09:54:05 +0100
Message-Id: <1138006445.2977.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 09:47 +0100, Heiko Carstens wrote:
> > > > Just wondering what people think of the idea of using a helper
> > > > function to split higher order pages instead of doing it manually?
> > > 
> > > Maybe it's worth documenting that this is for kernel (or even
> > > architecture) internal use only and that drivers really shouldn't be
> > > doing this..
> > 
> > I guess it doesn't seem like something drivers would need to use
> > (and none appear to do anything like it).
> 
> And I thought this could/should be used together with vm_insert_page() that
> drivers are supposed to use nowadays instead of remap_pfn_range().
> Why shouldn't drivers use this?

because in that case the drivers shouldn't allocate higher order pages
in the first place...


