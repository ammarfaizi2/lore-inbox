Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTLGRkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLGRkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:40:40 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:51977 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264460AbTLGRkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:40:39 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, linux-aio@kvack.org
Subject: Re: aio on ramfs
References: <20031207083432.GP19856@holomorphy.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 08 Dec 2003 02:40:03 +0900
In-Reply-To: <20031207083432.GP19856@holomorphy.com>
Message-ID: <87ptf0h6h8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> +static int ramfs_writepage(struct page *page, struct writeback_control *wbc)
> +{
> +	return 0;
> +}

Doesn't this break the magic of shrink_list()? I think it need the
"return WRITEPAGE_ACTIVATE;" at least.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
