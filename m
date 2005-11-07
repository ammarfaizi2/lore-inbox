Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVKGGRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVKGGRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVKGGRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:17:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbVKGGRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:17:49 -0500
Date: Sun, 6 Nov 2005 22:17:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: + swap-migration-v5-lru-operations-tweaks.patch added to -mm
 tree
Message-Id: <20051106221738.02215417.akpm@osdl.org>
In-Reply-To: <2cd57c900511062115n5975fba7v@mail.gmail.com>
References: <200511010521.jA15Lpsm016996@shell0.pdx.osdl.net>
	<2cd57c900511062115n5975fba7v@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>
> 2005/11/1, akpm@osdl.org <akpm@osdl.org>:
> >
> > The patch titled
> >
> >      swap-migration-v5-lru-operations-tweaks
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      swap-migration-v5-lru-operations-tweaks.patch
> >
> >
> > From: Andrew Morton <akpm@osdl.org>
> >
> > Cc: Christoph Lameter <clameter@sgi.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> >
> >  include/linux/mm_inline.h |    4 +---
> >  mm/vmscan.c               |    6 +++---
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff -puN include/linux/mm_inline.h~swap-migration-v5-lru-operations-tweaks include/linux/mm_inline.h
> > --- devel/include/linux/mm_inline.h~swap-migration-v5-lru-operations-tweaks     2005-10-31 21:21:48.000000000 -0800
> > +++ devel-akpm/include/linux/mm_inline.h        2005-10-31 21:21:48.000000000 -0800
> > @@ -44,8 +44,7 @@ del_page_from_lru(struct zone *zone, str
> >   *
> >   * - zone->lru_lock must be held
> >   */
> > -static inline int
> > -__isolate_lru_page(struct zone *zone, struct page *page)
> > +static inline int __isolate_lru_page(struct zone *zone, struct page *page)
> >  {
> >         if (TestClearPageLRU(page)) {
> >                 if (get_page_testone(page)) {
> 
> My curiosity, why we do this when the former is friendly to grep?

It's easier to read.

> Any coding style document about this?

Dunno.  I have a rude email from Linus here somewhere from when I used to
do it that way ;)

