Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWCXHUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWCXHUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWCXHUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:20:25 -0500
Received: from main.gmane.org ([80.91.229.2]:35550 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751555AbWCXHUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:20:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Edouard Gomez <ed.gomez@free.fr>
Subject: Re: 2.6.16-ck1
Date: Fri, 24 Mar 2006 07:58:03 +0100
Message-ID: <e0059s$vud$1@sea.gmane.org>
References: <200603202145.31464.kernel@kolivas.org>	<20060323113118.GA9329@spherenet.spherevision.org>	<dvv0ob$nql$1@sea.gmane.org> <20060323223138.GA9305@hassard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: edgomez.kicks-ass.org
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9a1) Gecko/20060202 SeaMonkey/1.5a
In-Reply-To: <20060323223138.GA9305@hassard.net>
Cc: ck@vds.kolivas.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hassard wrote:
> sky2 1.0?
> 
> Looks like a found the root cause of the sky2 hangs on pci-express. I 
> copied some code from the SysKonnect driver that reconfigured the 
> pci-express max request size. This probably caused receive dma engine to 
> fail in face of contention. That will teach me to stop copy/pasting in 
> bugs.
> ---
> 
> It might fix some of you issues ..

I'll backport again from git. The patch i sent was equivalent to 2.6.16 
sky2 module, but i see new patches that came in netdev-2.6.

[PATCH] sky2: more ethtool stats
[PATCH] sky2 version 1.1
[PATCH] sky2: handle all error irqs
[PATCH] sky2: transmit recovery
[PATCH] sky2: whitespace fixes
[PATCH] sky2: add MSI support
[PATCH] sky2: coalescing parameters
[PATCH] sky2: rework of NAPI and IRQ management
[PATCH] sky2: drop broken wake on lan support
[PATCH] sky2: remove support for untested Yukon EC ...
sky2: truncate oversize packets
sky2: force early transmit interruptsdiff to current
sky2: not random enough

-- 
Edouard Gomez

