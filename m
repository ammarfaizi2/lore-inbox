Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUFWH2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUFWH2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 03:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUFWH2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 03:28:07 -0400
Received: from adsl-101-86.38-151.net24.it ([151.38.86.101]:44299 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S266366AbUFWH2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 03:28:04 -0400
Date: Wed, 23 Jun 2004 09:28:02 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Dominik Karall <dominik.karall@gmx.net>
Subject: Re: 2.6.7-mm1
Message-ID: <20040623072802.GB1886@gateway.milesteg.arr>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Dominik Karall <dominik.karall@gmx.net>
References: <20040620174632.74e08e09.akpm@osdl.org> <200406211248.08190.dominik.karall@gmx.net> <20040621040029.48367636.akpm@osdl.org> <200406211343.50142.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406211343.50142.dominik.karall@gmx.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 01:43:47PM +0200, Dominik Karall wrote:
> On Monday 21 June 2004 13:00, Andrew Morton wrote:
> > Bummer.  Does this reversion fix it?
> 
> Yes. With this patch it works, but it works in that way, that the wrong 
> transceiver will be set as default. Maybe the current bk-netdev.patch is 
> incompatible with this patch? Or something isn't ok in bk-netdev.patch?
> Because the SiS900 patch is long time in -mm tree now, and it worked before!
> 
> greets dominik
> 
> > diff -puN drivers/net/sis900.c~a drivers/net/sis900.c
> > --- 25/drivers/net/sis900.c~a	2004-06-21 04:00:05.242017088 -0700
> > +++ 25-akpm/drivers/net/sis900.c	2004-06-21 04:00:07.832623256 -0700

This patch fixes a real bug in the detection of the active PHY when the
hardware is slightly broken and reports multiple PHY trancievers. Jeff
has some issues with the patch, but said he would check on them.

Since Dominik's NIC stoppen working in 2.6.7-mm1, there is some change
in that version that broke the driver, but the patch in discussion here
is the same (reversed) that I wrote and test with Dominik.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

