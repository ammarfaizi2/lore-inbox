Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTLGS4C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLGS4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:56:02 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:51466 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264488AbTLGS4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:56:00 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, linux-aio@kvack.org
Subject: Re: aio on ramfs
References: <20031207083432.GP19856@holomorphy.com>
	<87ptf0h6h8.fsf@devron.myhome.or.jp>
	<20031207175013.GF14258@holomorphy.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 08 Dec 2003 03:55:40 +0900
In-Reply-To: <20031207175013.GF14258@holomorphy.com>
Message-ID: <87fzfwh2z7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> William Lee Irwin III <wli@holomorphy.com> writes:
> >> +static int ramfs_writepage(struct page *page, struct writeback_control *wbc)
> >> +{
> >> +	return 0;
> >> +}
> 
> On Mon, Dec 08, 2003 at 02:40:03AM +0900, OGAWA Hirofumi wrote:
> > Doesn't this break the magic of shrink_list()? I think it need the
> > "return WRITEPAGE_ACTIVATE;" at least.
> 
> In truth these things shouldn't be on the LRU at all, though they're
> probably blindly plopped down there. My handwavy argument was that it
> makes no sense to do anything with it on the LRU and that I'd nopped
> out ->set_page_dirty() anyhow (i.e. PG_dirty should never get set). Does
> that hold enough water or should I still hand back WRITEPAGE_ACTIVATE?

I see. Sorry for noise.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
