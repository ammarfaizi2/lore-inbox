Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264108AbTCXFVc>; Mon, 24 Mar 2003 00:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264110AbTCXFVc>; Mon, 24 Mar 2003 00:21:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45001 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264108AbTCXFVc>;
	Mon, 24 Mar 2003 00:21:32 -0500
Date: Sun, 23 Mar 2003 21:29:50 -0800 (PST)
Message-Id: <20030323.212950.05858732.davem@redhat.com>
To: mk@linux-ipv6.org
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi-core@linux-ipv6.org
Subject: Re: [PATCH] IPv6 Extension headers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <87of48h6f8.wl@karaba.org>
References: <20030306093219.1a702868.kazunori@miyazawa.org>
	<20030305.204348.130225511.davem@redhat.com>
	<87of48h6f8.wl@karaba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mitsuru KANDA / 神田 充 <mk@linux-ipv6.org>
   Date: Tue, 18 Mar 2003 10:32:27 -0800
   
   Could you check this patch?
   (This patch is against 2.5.65.)

I applied this patch with some minor changes.

First, many functions in net/ipv6/exthdrs.c and net/ipv6/reassembly.c
can be marked static now.

Second, some local variables (for example, "nhoff" in ip6_input()) can
be eliminated entirely because they compute a value in one place and
use it in the very next line and nowhere else is it referenced.

Thank you.
