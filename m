Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSHJBuh>; Fri, 9 Aug 2002 21:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSHJBuh>; Fri, 9 Aug 2002 21:50:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316579AbSHJBuh>;
	Fri, 9 Aug 2002 21:50:37 -0400
Date: Fri, 09 Aug 2002 18:41:04 -0700 (PDT)
Message-Id: <20020809.184104.68900725.davem@redhat.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <8740.1028943304@ocs3.intra.ocs.com.au>
References: <20020809.180500.87139790.davem@redhat.com>
	<8740.1028943304@ocs3.intra.ocs.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Sat, 10 Aug 2002 11:35:04 +1000
   
   af_unix.c is linked into unix.o so we have -DKBUILD_MODNAME=unix.  Alas
   we also have -Dunix=1.  __stringify(KBUILD_MODNAME) -> __stringify(unix) ->
   "1" instead of "unix".
   
This seems really tacky.  There must be a better way to do this.
Perhaps prepending some constant string prefix to these module
names such that they will not collide with the namespace in
this way.  For example, "kmod_".
