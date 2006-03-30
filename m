Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWC3ICZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWC3ICZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWC3ICY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:02:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49602 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932091AbWC3ICX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:02:23 -0500
Date: Thu, 30 Mar 2006 10:02:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
In-Reply-To: <20060330073342.GK13476@suse.de>
Message-ID: <Pine.LNX.4.61.0603301000580.30783@yvahk01.tjqt.qr>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org>
 <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org> <20060329180830.50666eff.akpm@osdl.org>
 <20060330072149.GI13476@suse.de> <20060329233037.14a24d4f.akpm@osdl.org>
 <20060330073342.GK13476@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK..  Do you plan to make it reject unrecognised flags?
>
>Depends, not sure if eg a 'move' flag should be a hard or soft
>indication. Say we can't move a page and the caller asked us to migrate,
>we'd probably just do the sane thing and copy that one page. It would be
>silly to fail that request entirely.
>

Another bit in the flags:

enum {
    SPLICE_COPY       = 1 << 0,
    SPLICE_MOVE       = 1 << 1,
    SPLICE_MOVEORCOPY = 1 << 2, // fallback to copy if move fails
};


Jan Engelhardt
-- 
