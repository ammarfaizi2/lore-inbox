Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265772AbSJTFRq>; Sun, 20 Oct 2002 01:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSJTFRq>; Sun, 20 Oct 2002 01:17:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33240 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265772AbSJTFRp>;
	Sun, 20 Oct 2002 01:17:45 -0400
Date: Sat, 19 Oct 2002 22:15:57 -0700 (PDT)
Message-Id: <20021019.221557.124671756.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021020050849.GD15254@conectiva.com.br>
References: <20021020010331.GB15254@conectiva.com.br>
	<20021019.211307.00017347.davem@redhat.com>
	<20021020050849.GD15254@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 20 Oct 2002 02:08:49 -0300

BTW:
   
   CONFIG_PROC_FS=y
   [acme@oops net-2.5]$ l net/ipv4/built-in.o
   -rw-rw-r--    1 acme     acme       328783 Out 20 01:44 net/ipv4/built-in.o
   
   CONFIG_PROC_FS=n
   [acme@oops net-2.5]$ l net/ipv4/built-in.o
   -rw-rw-r--    1 acme     acme       320708 Out 20 02:03 net/ipv4/built-in.o

Do not be fooled by build-in.o raw file sizes, a lot of the stuff in
these unlinked objects are the unresolved symbol references that need
to be fixed up by the final link of the kernel image.

Type "objdump --reloc built-in.o" and watch it fly by the screen :-)
