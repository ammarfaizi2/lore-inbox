Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTI0XwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTI0XwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:52:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56217 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262278AbTI0XwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:52:09 -0400
Date: Sat, 27 Sep 2003 16:38:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Anton Blanchard <anton@samba.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
Message-Id: <20030927163827.241dbb4c.davem@redhat.com>
In-Reply-To: <20030926135908.GB9381@krispykreme>
References: <A8WS.6Uf.9@gated-at.bofh.it>
	<A8WR.6Uf.7@gated-at.bofh.it>
	<Aezg.6hA.9@gated-at.bofh.it>
	<m3zngqhmfr.fsf@averell.firstfloor.org>
	<20030926135908.GB9381@krispykreme>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 23:59:08 +1000
Anton Blanchard <anton@samba.org> wrote:

> 
> > Just curious - what does the X server use on these many systems then ?
> 
> FYI ppc64 and some ppc32 systems fall into the cant use /dev/mem
> category. The answer is to use pci domains (ie using /proc/bus/pci/...
> to be able to mmap PCI memory and IO regions)

Exactly.

XFREE86-4.3.0 and later has full domain infrastructure, it just isn't
enabled on anything other than ppc and sparc because the other platforms
haven't made their /proc/bus/pci/* mmap() arch support routines fully
functional yet.
