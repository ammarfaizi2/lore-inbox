Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSH3Xih>; Fri, 30 Aug 2002 19:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSH3Xih>; Fri, 30 Aug 2002 19:38:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27571 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315275AbSH3Xih>;
	Fri, 30 Aug 2002 19:38:37 -0400
Date: Fri, 30 Aug 2002 16:36:56 -0700 (PDT)
Message-Id: <20020830.163656.76075937.davem@redhat.com>
To: torvalds@transmeta.com
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for fs/aio.c on non-highmem systems
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208301641150.5430-100000@home.transmeta.com>
References: <20020830.162126.08406551.davem@redhat.com>
	<Pine.LNX.4.44.0208301641150.5430-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Fri, 30 Aug 2002 16:42:39 -0700 (PDT)
   
   I don't really much care how it gets fixed, I could equally well imagine
   having a dummy struct when CONFIG_HIGHMEM isn't set. Whatever makes the 
   dang thing work. There's certainly a good argument that non-broken 
   architectures shouldn't need to bother with kmap() at all..

Or that since the enumeration values are basically identical
on every system that the belong in linux/kmap_types.h :-)
