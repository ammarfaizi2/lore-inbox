Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUGPRUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUGPRUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUGPRUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:20:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:37894 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266603AbUGPRTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:19:39 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 17 Jul 2004 02:18:56 +0900
In-Reply-To: <20040716164435.GA8078@ucw.cz>
Message-ID: <87hds7lvjz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sat, Jul 17, 2004 at 01:35:59AM +0900, OGAWA Hirofumi wrote:
> > KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
> > key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
> > 
> > 	key_map[0] = U(K_ALLOCATED);
> > 	for (j = 1; j < NR_KEYS; j++)
> > 		key_map[j] = U(K_HOLE);
> 
> The patch below might cause problems, though, because some apps may (in
> old versions are) using a char variable to index up to NR_KEYS, which
> leads to an endless loop.

Maybe. But isn't it just bug of apps?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
