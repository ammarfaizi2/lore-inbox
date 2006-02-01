Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422974AbWBAWNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWBAWNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422975AbWBAWNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:13:12 -0500
Received: from mail.ccur.com ([66.10.65.12]:3747 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1422974AbWBAWNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:13:11 -0500
Message-ID: <43E13273.5020202@ccur.com>
Date: Wed, 01 Feb 2006 17:13:07 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>, bugsy@ccur.com
Subject: CONFIG_K8_NUMA x86_64 no-memory node bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2006 22:13:08.0609 (UTC) FILETIME=[AEA49F10:01C6277C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to mention a bug with the x86_64 CONFIG_K8_NUMA support.

We have a 4 CPU AMD Opteron (processor 846 -- no dual core) system that
boots up with a 2.6.15.2-based kernel with NUMA enabled if all the numa
nodes are populated with memory modules.

If we then pull out the memory module for the 3rd CPU/node, then the
kernel will no longer boot.

In this configuration, after the grub 'boot' command is entered, no
output is seen, and the system appears to be hung.

While this is admittedly a 'degraded' configuration, it would be nice
if the kernel could handle having a middle numbered node without memory.

I believe that removing the 4th CPU's memory module so that only the
last CPU/node is without memory, then the system boots up fine.

It seems that having a middle node without memory is what causes this
problem to occur.

Thanks for reading this.

