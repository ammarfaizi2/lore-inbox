Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318912AbSG1GzV>; Sun, 28 Jul 2002 02:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318913AbSG1GzV>; Sun, 28 Jul 2002 02:55:21 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:13130 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318912AbSG1GzU>; Sun, 28 Jul 2002 02:55:20 -0400
Date: Sun, 28 Jul 2002 09:58:33 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
Message-ID: <20020728065830.GT1465@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Buddy Lumpkin <b.lumpkin@attbi.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <1027813211.21516.2.camel@irongate.swansea.linux.org.uk> <FJEIKLCALBJLPMEOOMECOEPGCPAA.b.lumpkin@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FJEIKLCALBJLPMEOOMECOEPGCPAA.b.lumpkin@attbi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 03:39:41PM -0700, you [Buddy Lumpkin] wrote:
> 
> Why would you want to push *anything* to swap until you have to?

If you have idle io time in your hands, you can choose to back up some dirty
anonymous pages to the swap device. This way, when pages really needs to get
freed, you can just drop the pages (just like you would drop clean file
backed pages.) This obviously eliminates a great latency (somebody said
something about a "swap storm"), because the write happened beforehand.

There's nothing wrong with the swap being in use (and the pages may still be
in memory). If you have swap, it makes sense to use it. What doesn't make
sense is to waste time waiting for paging to happen.


-- v --

v@iki.fi
