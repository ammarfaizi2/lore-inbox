Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTLOErz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 23:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTLOErz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 23:47:55 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:25106 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263082AbTLOEry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 23:47:54 -0500
Date: Sun, 14 Dec 2003 23:47:16 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@redhat.com>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215044716.GA2706@devserv.devel.redhat.com>
References: <3FDCA569.5070006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDCA569.5070006@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 14 Dec 2003 19:28:37 +0200
> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

> +++ linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h	2003-12-14 11:08:17.000000000 +0200

Generally I'm pretty tolerant of bizzare spacing, but in this
case tabs were mixed into the patch, which causes funny effects.

> +union pci_exp_data {
> +    u32 l;
> +    u16 w[2];
> +    u8  b[4];
> +} __attribute__((packed));

Bogus __attribute__((packed)), but it's only the begining.
Whole thing is used where shifts would have worked.

> +static void pci_express_fini(void)
> +{
> +    if (rrbar_virt) {	<====== Not trusting own code
> +        iounmap(rrbar_virt);
> +    }

All in all, raw. Also, a healthy dose of Itanium is prescribed.

-- Pete
