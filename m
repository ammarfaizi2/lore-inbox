Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbUK3JGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUK3JGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 04:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUK3JGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 04:06:12 -0500
Received: from canuck.infradead.org ([205.233.218.70]:57618 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262028AbUK3JFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 04:05:30 -0500
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for
	CONFIG_XEN
From: Arjan van de Ven <arjan@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <E1CZ3oT-0001tU-00@mta1.cl.cam.ac.uk>
References: <E1CZ3oT-0001tU-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Message-Id: <1101805486.2640.37.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 10:04:46 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Tue, 2004-11-30 at 08:56 +0000, Ian Pratt wrote:

> In the Xen case, we actually need to use io_remap_page_range for
> all /dev/mem accesses, so as to be able to map the BIOS area, DMI
> tables etc.
> 

look at the /dev/mem patches in the -mm tree... there might be
infrastructure there that is useful to you


> I wasn't sure how best to handle the fact that /dev/kmem shared
> its mmap implementation with /dev/mem.  BTW: Does anyone know of
> any programs that make use of mmap'ing /dev/kmem?

effectively nothing uses /dev/kmem; you might as well just remove it
entirely and/or not provide it in Xen.


