Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWFUQy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWFUQy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFUQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:54:57 -0400
Received: from ns.suse.de ([195.135.220.2]:55446 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932161AbWFUQy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:54:56 -0400
From: Andi Kleen <ak@suse.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] x86_64: Do not use -ffunction-sections for modules
Date: Wed, 21 Jun 2006 18:54:00 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <11509074684035-git-send-email-vsu@altlinux.ru> <200606211841.33220.ak@suse.de> <20060621165126.GB4126@master.mivlgu.local>
In-Reply-To: <20060621165126.GB4126@master.mivlgu.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211854.00790.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 June 2006 18:51, Sergey Vlasov wrote:

> > On Thursday 01 January 1970 01:00, Sergey Vlasov wrote:
> > > Currently CONFIG_REORDER uses -ffunction-sections for all code;
> > > however, creating a separate section for each function is not useful
> > > for modules and just adds bloat. 
> > 
> > You mean the ELF files are larger?
> 
> Yes, and all these sections are then reported in sysfs (BTW, what programs
> really use /sys/module/*/sections/* files?).

Good question. I also always considered it bloat.

> 
> > .text/.data size shouldn't > change in theory.
> 
> Actually, it does change by a small amount for some reason - even
> increases by about 100 bytes in some cases;

Ok maybe a few small vs large jumps

> however, I suppose that the 
> size reported by /proc/modules and lsmod is more important, and it
> decreases:

Ok thanks.

-Andi
