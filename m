Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVGEXJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGEXJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVGEXJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:09:24 -0400
Received: from ozlabs.org ([203.10.76.45]:34507 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261908AbVGEXEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:04:12 -0400
Date: Wed, 6 Jul 2005 08:59:08 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
Message-ID: <20050705225908.GL12786@krispykreme>
References: <20050705224528.GJ12786@krispykreme> <Pine.LNX.4.62.0507051550120.1806@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507051550120.1806@graphe.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ummm. But it has multiple memory nodes? We ran into trouble with the funky
> memory arrangement before.

Its a shared processor partition (meaning the partition can get
scheduled anywhere), so we throw all the cpus and memory into node 0.

This machine only has 1 cpu (2 threads) and they are both in node0:

# ls -l /sys/devices/system/node/node0/

lrwxrwxrwx 1 root root 0 Jul 5 17:56 cpu0 -> ../../../../devices/system/cpu/cpu0
lrwxrwxrwx 1 root root 0 Jul 5 17:56 cpu1 -> ../../../../devices/system/cpu/cpu1

Anton
