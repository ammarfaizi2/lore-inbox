Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSFQLHg>; Mon, 17 Jun 2002 07:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSFQLHf>; Mon, 17 Jun 2002 07:07:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21376 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316897AbSFQLHf>;
	Mon, 17 Jun 2002 07:07:35 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 17 Jun 2002 13:07:04 +0200 (MEST)
Message-Id: <UTC200206171107.g5HB74t13348.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dwmw2@infradead.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: David Woodhouse <dwmw2@infradead.org>

    +int jffs2_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
    +                  const char **llink, struct page **ppage)

    +    nd->flags |= LOOKUP_KFREE_NEEDED;

    Urgh. Don't do that on my behalf - we'll just switch to using 
    page_follow_link, which to be honest I thought we'd already done -- 
    there were definitely patches for it floating around.

Good. I think it would be worthwhile to find and submit such patches.
Not just for this attempt of mine, but it is generally a good idea
to keep things as uniform as possible.

I think these two ugly bits, and the entire nd argument of
prepare_follow_link can be eliminated, but apart from jffs2
that also requires a little work in proc.

Andries
