Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313172AbSDKH7c>; Thu, 11 Apr 2002 03:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSDKH7b>; Thu, 11 Apr 2002 03:59:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61394 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313172AbSDKH7b>;
	Thu, 11 Apr 2002 03:59:31 -0400
Date: Thu, 11 Apr 2002 00:52:16 -0700 (PDT)
Message-Id: <20020411.005216.107061041.davem@redhat.com>
To: taka@valinux.co.jp
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020411.164134.85392767.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Thu, 11 Apr 2002 16:41:34 +0900 (JST)

   Now I wonder if we could make these pages COW mode.
   When some process try to update the pages, they should be duplicated.
   I's easy to implement it in write(), truncate() and so on.
   But mmap() is little bit difficult if there no reverse mapping page to PTE.
   
   How do you think about this idea?

I think this idea has such high overhead that it is even not for
consideration, consider SMP.
