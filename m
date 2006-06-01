Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWFARev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWFARev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWFAReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:34:50 -0400
Received: from stinky.trash.net ([213.144.137.162]:34559 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S965247AbWFARet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:34:49 -0400
Message-ID: <447F2537.1080807@trash.net>
Date: Thu, 01 Jun 2006 19:34:47 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
References: <20060531094626.GA23156@janus> <447DAEC9.3050003@trash.net> <20060531160611.GA25637@janus> <447DC613.10102@trash.net> <20060531172936.GB25788@janus> <447DD66C.30605@trash.net> <20060601091124.GA31642@janus>
In-Reply-To: <20060601091124.GA31642@janus>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> ok, now "tc -s -d qdisc show" says (after noticing missing netconsole
> packets):
> 
> qdisc pfifo_fast 0: dev eth0 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
>  Sent 155031 bytes 2067 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 


Mhh no dropped packets. I tried to reproduce the problem by changing
netconsole to always use the dev_queue_xmit path, but works flawlessly
for me. Please try to find out if the packets are lost before or after
the qdisc by looking at the packet counter.

BTW: You still haven't sent me the packet dump (from the originating
machine).

