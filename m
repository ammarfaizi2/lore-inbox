Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUK3MOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUK3MOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbUK3MOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:14:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63492 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262045AbUK3MOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:14:34 -0500
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for
	CONFIG_XEN
From: Arjan van de Ven <arjan@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <E1CZ6op-0005QS-00@mta1.cl.cam.ac.uk>
References: <E1CZ6op-0005QS-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Message-Id: <1101816850.2640.43.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 13:14:10 +0100
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

On Tue, 2004-11-30 at 12:09 +0000, Ian Pratt wrote:
> > On Tue, 2004-11-30 at 08:56 +0000, Ian Pratt wrote:
> > 
> > > In the Xen case, we actually need to use io_remap_page_range for
> > > all /dev/mem accesses, so as to be able to map the BIOS area, DMI
> > > tables etc.
> > 
> > look at the /dev/mem patches in the -mm tree... there might be
> > infrastructure there that is useful to you
> 
> Thanks for the pointer. Having looked through, it's orthogonal
> and can't help us, though doesn't conflict with our patch either
> (fuzz 2).

well.. it makes all non-ram unaccessible... so what's left is only the
stuff Xen wants to make accessible anyway :)


