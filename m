Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUIMVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUIMVto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIMVto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:49:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63381 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268914AbUIMVrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:47:45 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm5 scheduling while atomic
Date: Mon, 13 Sep 2004 14:47:41 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131447.41607.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an Altix with the default config (smp+preempt, see 
arch/ia64/configs/sn2_defconfig), I'm getting this:

bad: scheduling while atomic!

Call Trace:
 [<a000000100017380>] show_stack+0x80/0xa0
                                sp=e0001c3004adfc40 bsp=e0001c3004ad9098
 [<a0000001006bcc70>] schedule+0x11f0/0x16a0
                                sp=e0001c3004adfe10 bsp=e0001c3004ad8f78
 [<a000000100018530>] cpu_idle+0x5b0/0x620
                                sp=e0001c3004adfe30 bsp=e0001c3004ad8ee8
 [<a000000100059a10>] start_secondary+0x2d0/0x300
                                sp=e0001c3004adfe30 bsp=e0001c3004ad8eb0
 [<a000000100008580>] _start+0x260/0x290
                                sp=e0001c3004adfe30 bsp=e0001c3004ad8eb0

The messages began right after I logged out of an ssh session and haven't 
stopped yet.

Jesse
