Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271225AbTHMAOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbTHMAOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:14:35 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:23409 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S271225AbTHMAOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:14:32 -0400
Date: Tue, 12 Aug 2003 17:14:36 -0700
From: Ken Savage <kens1835@shaw.ca>
Subject: Re: High CPU load with kswapd and heavy disk I/O
In-reply-to: <3F397CED.6060006@vgertech.com>
To: linux-kernel@vger.kernel.org
Message-id: <200308121714.36993.kens1835@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
References: <200308121136.11979.kens1835@shaw.ca>
 <200308121323.49081.kens1835@shaw.ca> <3F397CED.6060006@vgertech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue August 12 2003 16:49, Nuno Silva wrote:

> My guess is that this is the cause. LOWMEM pressure because of very
> large directories... Relating to this, linux-2.6.0-test3-mm1 has Ingo's
> 4G/4G memory split. Can you try this kernel, enable 4G/4G feature, and
> report back?

Something about the 2.6 (and the rmap patched 2.4) kernels causes
lockouts on the server -- for reasons OTHER than kswapd.  The server
running the delete-old-files process runs hundreds of other CPU and disk
I/O intensive processes/threads, and it doesn't look like 2.6 is yet able
to handle the load.  Unfortunately, the server is a production environment
machine at a remote site, so lockouts/reboots/kernel panics are baaaad :(

I've seen other mentions of kswapd/kupdated problems in 2.4.xx, but
few mentions of solutions.  Have people just learned to avoid the
situations that trigger the mad thrashes?

Ken
