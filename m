Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbTIDMxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTIDMxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:53:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264968AbTIDMvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:51:51 -0400
Date: Thu, 4 Sep 2003 05:41:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: geert@linux-m68k.org, hch@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904054144.33004def.davem@redhat.com>
In-Reply-To: <16215.13051.836875.270440@nanango.paulus.ozlabs.org>
References: <16215.7181.755868.593534@nanango.paulus.ozlabs.org>
	<Pine.GSO.4.21.0309041420460.8244-100000@waterleaf.sonytel.be>
	<16215.13051.836875.270440@nanango.paulus.ozlabs.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 22:41:31 +1000 (EST)
Paul Mackerras <paulus@samba.org> wrote:

> Geert Uytterhoeven writes:
> 
> > `ioremap is meant for PCI memory space only'
> 
> Did I say that, or someone else? :)  ioremap predates PCI support by a
> long way IIRC...

No, it really is true.

If only your non-pci drivers need to get at the larger
physical addresses, perhaps a easier short term solution
is to just use a special ppc_foo_ioremap() for them.
