Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSJPGlI>; Wed, 16 Oct 2002 02:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264914AbSJPGlI>; Wed, 16 Oct 2002 02:41:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42925 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264925AbSJPGlH>;
	Wed, 16 Oct 2002 02:41:07 -0400
Date: Tue, 15 Oct 2002 23:39:14 -0700 (PDT)
Message-Id: <20021015.233914.68256249.davem@redhat.com>
To: acme@conectiva.com.br
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: udp seq_file support: produce only one record
 per seq_show
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016062449.GC1352@conectiva.com.br>
References: <20021016062449.GC1352@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Wed, 16 Oct 2002 03:24:49 -0300
   
   master.kernel.org:/home/acme/BK/net-2.5

Pulled.

Two notes:

1) ARP and FIB hacks need similar treatment
2) I don't think it's so nice to snprintf() onto the
   stack and then seq_printf() that in fib_node_seq_show.

   You should be able to keep the line within it's
   limit length just by specifying lengths to the integer
   formats.

Thanks.
