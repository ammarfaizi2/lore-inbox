Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVD0QTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVD0QTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVD0QTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:19:15 -0400
Received: from [213.170.72.194] ([213.170.72.194]:29419 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261780AbVD0QTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:19:10 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org, viro@math.psu.edu,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=KOI8-R
Organization: MTD
Date: Wed, 27 Apr 2005 20:19:08 +0400
Message-Id: <1114618748.12617.23.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Срд, 27/04/2005 в 17:57 +0200, Miklos Szeredi пишет:
> On second thought a wake_up_inode() seems to be missing in
> dispose_list() just before destroy_inode().  
Good point, thanks.

> Also I'm not sure delaying removal from i_sb_list is the right thing.
> generic_delete_inode() does this before clear_inode().
As I can see, dispose_list() doesn't correlate with generic_delete_inode
() code path, so this mustn't be a problem.

What am I supposed to do next? I already sent the old patch with the
error to Andrew Morton. Should I notify him about this? Just resend?
Whatever?

Cheers,
Artem.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

