Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVD1HeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVD1HeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVD1HeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:34:15 -0400
Received: from [213.170.72.194] ([213.170.72.194]:16601 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262016AbVD1HcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:32:10 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: MTD
Date: Thu, 28 Apr 2005 11:32:08 +0400
Message-Id: <1114673528.3483.2.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do you need to move it from prune_icache() to dispose_list()?
> For the hash list it's the right thing, but for sb_list it's not
> needed, is it?
Yes, it is not needed but harmless. I did it only because i_hash &
i_sb_list insertions/deletions always come in couple. So I decided move
them both, to be more consistent, to make code less complicated.

If you regard this hazardous I might split these removals. But IMHO, my
variant is a bit more pleasant.

> Retest, and resend.
Thanks.

I assume I don't need to notify Andrew about the inconsistency in the
old patch, or should I?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

