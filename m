Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbSLKBCt>; Tue, 10 Dec 2002 20:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbSLKBCs>; Tue, 10 Dec 2002 20:02:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32155 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266928AbSLKBCo>;
	Tue, 10 Dec 2002 20:02:44 -0500
Date: Tue, 10 Dec 2002 17:06:44 -0800 (PST)
Message-Id: <20021210.170644.97772177.davem@redhat.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021210222842.GA64@DervishD>
References: <20021210221357.GA46@DervishD>
	<20021210.141451.66294590.davem@redhat.com>
	<20021210222842.GA64@DervishD>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: DervishD <raul@pleyades.net>
   Date: Tue, 10 Dec 2002 23:28:42 +0100
   
   > How about something like:
   > 
   > 	if (len == 0)
   > 		return addr;
   > 
   > 	len = PAGE_ALIGN(len);
   > 	if (len > TASK_SIZE || len == 0)
   > 		return -EINVAL;
   > 
   > That should cover all cases and not make the TASK_SIZE assumption.
   
       Perfect :) If you want, I can make the patch and tell to Alan and
   Linus. Anyway, I think you will better heared than me O:))
   
If you could take care of this, I would really be happy.

       Anyway, I'll take a look at a new macro (lets say PAGE_ALIGN_SIZE
   or something as ugly as this ;)))
   
How many places do we try to apply PAGE_ALIGN to a length?
If it's just one or two spots, perhaps the special macro
isn't worthwhile.
