Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbSLJVSH>; Tue, 10 Dec 2002 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSLJVSH>; Tue, 10 Dec 2002 16:18:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64153 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266777AbSLJVSG>;
	Tue, 10 Dec 2002 16:18:06 -0500
Date: Tue, 10 Dec 2002 13:22:07 -0800 (PST)
Message-Id: <20021210.132207.23687680.davem@redhat.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021210205906.GA82@DervishD>
References: <20021210204530.GA63@DervishD>
	<20021210.124740.86261163.davem@redhat.com>
	<20021210205906.GA82@DervishD>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: DervishD <raul@pleyades.net>
   Date: Tue, 10 Dec 2002 21:59:06 +0100
   
       Because PAGE_ALIGN won't return 0?

What if TASK_SIZE is ~0?  Both your checks will pass
for the case of (SIZE_MAX-PAGE_SIZE + 1) to ~0 cases.

