Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263181AbVCXUWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbVCXUWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbVCXUWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:22:11 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:63449 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S263096AbVCXUVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:21:41 -0500
Message-ID: <42432132.4080105@ens-lyon.org>
Date: Thu, 24 Mar 2005 21:21:06 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Stefano Rivoir <s.rivoir@gts.it>, linux-kernel@vger.kernel.org,
       airlied@gmail.com
Subject: Re: 2.6.12-rc1-mm2
References: <20050324044114.5aa5b166.akpm@osdl.org>	<200503241540.33012.s.rivoir@gts.it>	<4242DA5A.4020904@ens-lyon.org>	<200503241631.30681.s.rivoir@gts.it> <20050324120504.32ee0656.akpm@osdl.org>
In-Reply-To: <20050324120504.32ee0656.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Stefano Rivoir <s.rivoir@gts.it> wrote:
>>>--- linux-mm/include/linux/agp_backend.h.old    2005-03-24
>>>16:17:25.000000000 +0100
>>>+++ linux-mm/include/linux/agp_backend.h        2005-03-24
>>>16:10:25.000000000 +0100
>>>@@ -100,6 +100,7 @@
>>>  extern int agp_bind_memory(struct agp_memory *, off_t);
>>>  extern int agp_unbind_memory(struct agp_memory *);
>>>  extern void agp_enable(struct agp_bridge_data *, u32);
>>>+extern struct agp_bridge_data * (*agp_find_bridge)(struct pci_dev *);
>>>  extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
>>>  extern void agp_backend_release(struct agp_bridge_data *);
>>
>>Right, that fixed it for me.
>>
> 
> 
> There were contradictory patches in flight and I stuck the latest drm tree
> into rc1-mm2 at the last minute, alas.  You should revert
> agp-make-some-code-static.patch.
> 
> But I assume that fixing the compile warnings does not fix the oopses which
> Stefano and Brice are seeing?

My patch does fix both the compile warnings and my oops on my Radeon laptop.

Brice
