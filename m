Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbUK2WfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbUK2WfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUK2Wda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:33:30 -0500
Received: from [69.55.226.176] ([69.55.226.176]:24767 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S261834AbUK2Wcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:32:52 -0500
Message-ID: <41ABA38E.3010507@drugphish.ch>
Date: Mon, 29 Nov 2004 23:32:46 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Followup-To: linux-net@vger.kernel.org
To: =?ISO-8859-1?Q?jo=EBl_Winteregg?= <joel.winteregg@eivd.ch>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: client socket and source port selection
References: <1101576123.744.31.camel@debian>
In-Reply-To: <1101576123.744.31.camel@debian>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> For the project i'm doing, i must know how the Linux kernel allocate
> sockets source port (from the dynamic range of the (2**16)-1 ports). I
> looked on the Web but it's really hard to find the algoritm of the
> source port allocation...

Check the source ;). There is a proc-fs entry which relates to the 
source port range setting. Over this entry point you get in case of TCP 
sockets to ../net/ipv4/tcp_ipv4.c:tcp_v4_get_port(...). For UDP sockets 
you need to peek into ../net/ipv4/udp.c:udp_v4_get_port().

> Someone maybe know how it's work or if there is a paper on the web that
> explain this source port selection ?

Not likely, but reading the source should help. You can set the local 
port range via /proc/sys/net/ipv4/ip_local_port_range. It's documented.

HTH and best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
