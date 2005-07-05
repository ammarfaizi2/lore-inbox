Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVGEXdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVGEXdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVGEXdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:33:51 -0400
Received: from graphe.net ([209.204.138.32]:55444 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261975AbVGEXdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:33:50 -0400
Date: Tue, 5 Jul 2005 16:33:42 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
In-Reply-To: <20050705225908.GL12786@krispykreme>
Message-ID: <Pine.LNX.4.62.0507051632100.2289@graphe.net>
References: <20050705224528.GJ12786@krispykreme> <Pine.LNX.4.62.0507051550120.1806@graphe.net>
 <20050705225908.GL12786@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Anton Blanchard wrote:

> Its a shared processor partition (meaning the partition can get
> scheduled anywhere), so we throw all the cpus and memory into node 0.
> 
> This machine only has 1 cpu (2 threads) and they are both in node0:
> 
> # ls -l /sys/devices/system/node/node0/
> 
> lrwxrwxrwx 1 root root 0 Jul 5 17:56 cpu0 -> ../../../../devices/system/cpu/cpu0
> lrwxrwxrwx 1 root root 0 Jul 5 17:56 cpu1 -> ../../../../devices/system/cpu/cpu1

What does pcibus_to_node return for the pcibus device that you are trying 
to allocate for?

There must be something special here. We have run this patch for a long 
time on a variety of platforms (not on powerpc I am afraid). Maybe a 
broken pcibus_to_node function for ppc?

