Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHZHeE>; Mon, 26 Aug 2002 03:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSHZHeE>; Mon, 26 Aug 2002 03:34:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38535 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317980AbSHZHeD>;
	Mon, 26 Aug 2002 03:34:03 -0400
Date: Mon, 26 Aug 2002 00:32:52 -0700 (PDT)
Message-Id: <20020826.003252.45745195.davem@redhat.com>
To: ldb@ldb.ods.org
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: Broken inlines all over the source tree
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030232838.1451.99.camel@ldb>
References: <1030232838.1451.99.camel@ldb>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Luca Barbieri <ldb@ldb.ods.org>
   Date: 25 Aug 2002 01:47:18 +0200

   ./include/net/ip.h

False positive, ip_finish_output is merely declared extern here with
the __inline__ attribute so that the functions args+attributes match
with what the real function definition has in net/ipv4/ip_output.c

We don't intend it to get inlined when called from other files :-)

   ./net/core/sock.c

ROFL, maybe your script is matching sk->urginline :-)
I can't find anything else in this file.

Franks a lot,
David S. Miller
davem@redhat.com
   
