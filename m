Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbULaKMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbULaKMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbULaKMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:12:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:26121 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261844AbULaKMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:12:44 -0500
Subject: Re: [PATCH] /proc/sys/kernel/bootloader_type
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       SYSLINUX@zytor.com
In-Reply-To: <20041231013443.313a3320.akpm@osdl.org>
References: <41D34E3A.3090708@zytor.com>
	 <20041231013443.313a3320.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 11:12:34 +0100
Message-Id: <1104487954.5402.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 01:34 -0800, Andrew Morton wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >
> > This patch exports to userspace the boot loader ID which has been 
> >  exported by (b)zImage boot loaders since boot protocol version 2.
> 
> Why does userspace need to know this?

so that update tools that update kernels from vendors know which
bootloader file they need to update; eg right now those tools do all
kinds of hairy heuristics to find out if it's grub or lilo or .. that
installed the kernel. Those heuristics are fragile in the presence of
more than one bootloader (which isn't that uncommon in OS upgrade
situations).


