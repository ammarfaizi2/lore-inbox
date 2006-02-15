Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422907AbWBOGyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422907AbWBOGyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422904AbWBOGyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:54:09 -0500
Received: from stinky.trash.net ([213.144.137.162]:35782 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1422907AbWBOGyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:54:07 -0500
Message-ID: <43F2CFB6.9030106@trash.net>
Date: Wed, 15 Feb 2006 07:52:38 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Taprogge <jlt_kernel@shamrock.dyndns.org>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter@lists.netfilter.org
Subject: Re: 2.6.16-rc3 panic related to IP Forwarding and/or Netfilter
References: <20060214173455.GA19355@ranger.taprogge.wh>
In-Reply-To: <20060214173455.GA19355@ranger.taprogge.wh>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Taprogge wrote:
> Hello.
> 
> After upgrading from 2.6.13 an IP Masquerading router panics as soon as
> soon as packages are forwarder (or rather should be).  As long as IP
> Masquerading is disabled (and thus no forwarding occurs) the box runs
> stable.
> 
> A picture of the panic ouput can be found at:
> http://shamrock.dyndns.org/~ln/kernel/2.6.16rc3_panic/panic.jpg
> The config is at:
> http://shamrock.dyndns.org/~ln/kernel/2.6.16rc3_panic/config-2.6.16-rc3-g51d6aa16-dirty
> 
> The kernel was patched to support SIP-contrack however the extra files
> have not been compiled and should thus have no influence.
> 
> Please cc me on replies as I am not subscribed to the lists.

Known problem, I'll submit a fix tonight. Until then you can avoid
the crash by making sure your masquerade rules don't change packets
which matched an IPsec policy so they don't match anymore.
