Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSH3XXJ>; Fri, 30 Aug 2002 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSH3XXI>; Fri, 30 Aug 2002 19:23:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20659 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311749AbSH3XXH>;
	Fri, 30 Aug 2002 19:23:07 -0400
Date: Fri, 30 Aug 2002 16:21:26 -0700 (PDT)
Message-Id: <20020830.162126.08406551.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for fs/aio.c on non-highmem systems
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020826175322.B6178@redhat.com>
References: <20020826175322.B6178@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 26 Aug 2002 17:53:22 -0400

   Patrik Mochel noticed that fs/aio.c doesn't compile on a non-highmem config.  
   The patch below (and in the bk tree on master.kernel.org:/home/bcrl/aio-2.5) 
   fixes that by making the helper functions #defines, and should also be a 
   bit faster.

Platforms should fix this by making a dummy asm/kmap_types.h

Linus added the explicit include of asm/kmap_types.h and therefore
I believe this is how he wants this fixed too.
