Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHFOGC>; Tue, 6 Aug 2002 10:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSHFOGB>; Tue, 6 Aug 2002 10:06:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43981 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313628AbSHFOF7>;
	Tue, 6 Aug 2002 10:05:59 -0400
Date: Tue, 06 Aug 2002 06:56:52 -0700 (PDT)
Message-Id: <20020806.065652.12285252.davem@redhat.com>
To: kasperd@daimi.au.dk
Cc: manfred@colorfullife.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D4FD736.DA443B4B@daimi.au.dk>
References: <3D4F942D.7020100@colorfullife.com>
	<20020806.022813.27560736.davem@redhat.com>
	<3D4FD736.DA443B4B@daimi.au.dk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kasper Dupont <kasperd@daimi.au.dk>
   Date: Tue, 06 Aug 2002 16:03:34 +0200

   "David S. Miller" wrote:
   > verify_area() checks aren't enough, consider a threaded application
   > calling mprotect() while the copy is in progress.
   
   Couldn't we just freeze all other processes with the same mm while
   a copy_to_user is in progress?

What if we have to sleep and page in some memory from disk?

Your idea could lead to deadlock in a multi-threaded app.
