Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUDAKql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUDAKqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:46:18 -0500
Received: from main.gmane.org ([80.91.224.249]:24767 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262843AbUDAKo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:44:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Balazs Ree <ree@ree.hu>
Subject: Re: HPT370 locks up (2.4/2.6)
Date: Thu, 01 Apr 2004 12:32:59 +0200
Message-ID: <pan.2004.04.01.10.32.57.982363@ree.hu>
References: <pan.2004.03.30.12.36.03.326699@ree.hu> <200403311054.01626.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 3e44b6eb.adsl.enternet.hu
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 10:54:01 +0200, Denis Vlasenko wrote:
> You may need to serialize channel usage in driver code if it indeed
> happens when both channels are working at the same time.

Thank you, this tip was really useful.

Setting #define HPT_SERIALIZE_IO in hpt366.h solves the lockups on my
machine (ABIT KT7-RAID). There seems to be a small (10-20%) performance
penalty involved according to the benchmarks on my RAID1 setup, but that's
acceptable.

If this solves the "hdd led stays on" freezups for others with HPT370
(rev. 3) on motherboards with possibly buggy IRQ handling, then maybe this
option could even be made settable through kernel config, together with an
appropriate explanation.

-- 
Balazs REE


