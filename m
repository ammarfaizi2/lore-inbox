Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTEROIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTEROIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:08:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30532 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262066AbTEROIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:08:41 -0400
Date: Sun, 18 May 2003 14:21:30 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: arjanv@redhat.com, Jes Sorensen <jes@wildopensource.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Colin Ngam <cngam@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
Subject: Re: [patch] support 64 bit pci_alloc_consistent
Message-ID: <20030518142130.A30977@devserv.devel.redhat.com>
References: <16071.1892.811622.257847@trained-monkey.org> <1053250142.1300.8.camel@laptop.fenrus.com> <1053267471.10811.28.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053267471.10811.28.camel@mulgrave>; from James.Bottomley@SteelEye.com on Sun, May 18, 2003 at 09:17:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 09:17:48AM -0500, James Bottomley wrote:
> (it uses 32 bit addr and 32 bit len descriptors, but reduces len to 24
> bits to steal the extra byte for 7 bits extra addressing).  However, it
> is forced to request the full 64 bit address mask---I've never worked
> out what will happen to it on a machine with more than 512GB memory.

Uh??? right now even in 2.4 arbitrary bitmasks are supported for
non-coherent memory.
