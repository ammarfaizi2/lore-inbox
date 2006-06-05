Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751152AbWFEOfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWFEOfA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWFEOe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:34:59 -0400
Received: from kanga.kvack.org ([66.96.29.28]:63944 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751146AbWFEOe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:34:59 -0400
Date: Mon, 5 Jun 2006 11:35:46 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] Use ld's garbage collection feature
Message-ID: <20060605143546.GA2878@dmt>
References: <20060605003152.GA1364@dmt> <200606042251.46575.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606042251.46575.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 10:51:45PM -0400, Dmitry Torokhov wrote:
> On Sunday 04 June 2006 20:31, Marcelo Tosatti wrote:
> > Current implementation requires "make modules" to be run before "make
> > vmlinux" (need to know what functions used by modules must be kept), but
> > 
> 
> How will it work with out of tree modules? Or even modules one decides
> to add later and use without rebooting?

Right, exported symbols must be kept in that case. An extra option to
enable exported symbol gc as dwmw2 suggests should do the trick.

