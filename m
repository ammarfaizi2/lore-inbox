Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279492AbRJXIiN>; Wed, 24 Oct 2001 04:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279495AbRJXIiE>; Wed, 24 Oct 2001 04:38:04 -0400
Received: from relay.planetinternet.be ([194.119.232.24]:23056 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S279492AbRJXIhz>; Wed, 24 Oct 2001 04:37:55 -0400
Date: Wed, 24 Oct 2001 10:38:13 +0200 (CEST)
From: Dirk Moerenhout <dirk@staf.planetinternet.be>
X-X-Sender: <dmoerenh@dirk>
To: J Sloan <jjs@lexus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: More memory == better?
In-Reply-To: <3BD5E2C5.26F5A133@lexus.com>
Message-ID: <Pine.LNX.4.33.0110241029100.208-100000@dirk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, J Sloan wrote:

> If you don't enable highmem support, you'll
> be able to use about 960 MB of your 1 GB -
> no big loss, right?

Actually if you wish you can use your full 1GB just fine without HIGHMEM:

In /proc/meminfo:
MemTotal:      1025360 kB
LowTotal:      1025360 kB

At boot:
kernel: On node 0 totalpages: 262128
kernel: zone(0): 4096 pages.
kernel: zone(1): 258032 pages.
kernel: zone(2): 0 pages.

The related config parameters:
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_1GB is not set
CONFIG_2GB=y
# CONFIG_3GB is not set

For what I know this trick just limits you on the amount of swap you can
have. The suggestion came from Ingo Molnar and it works fine for me.

Dirk Moerenhout ///// System Administrator ///// Planet Internet NV

