Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTJMKpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJMKpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:45:32 -0400
Received: from asplinux.ru ([195.133.213.194]:4362 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261328AbTJMKpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:45:31 -0400
From: Kirill Korotaev <kk@sw.ru>
Reply-To: kk@sw.ru
Organization: SWsoft
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Date: Mon, 13 Oct 2003 14:46:25 +0400
User-Agent: KMail/1.5.1
References: <200310131318.09234.kk@sw.ru> <20031013095347.GF16158@holomorphy.com>
In-Reply-To: <20031013095347.GF16158@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131446.25921.kk@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Untested brute-force forward port to 2.6.0-test7-bk4. No idea if the
> locking is correct or if list movement is done in all needed places.
First of all, thanks for forward port. I think this patch is quite usefull
for both 2.4 and 2.6 kernels, but I can't check it on all kernels myself.

comments:
1. why have you replaced list_del with list_del_init in my patch?
It's not required.
2. locks are ok, as for i_list, i_hash lists.
3. Missed 
+list_add(&inode->i_sb_list, &sb->s_inodes);
in get_new_inode_fast() function. Please add it.

I looked through, everything else looks ok.

[your patch]

Kirill

