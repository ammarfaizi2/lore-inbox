Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTERRKX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTERRKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 13:10:23 -0400
Received: from palrel11.hp.com ([156.153.255.246]:60830 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262135AbTERRKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 13:10:22 -0400
Date: Sun, 18 May 2003 10:22:03 -0700
From: Grant Grundler <iod00d@hp.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, jes@wildopensource.com,
       torvalds@transmeta.com, James.Bottomley@steeleye.com,
       grundler@dsl2.external.hp.com, cngam@sgi.com, jeremy@sgi.com,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org, wildos@sgi.com
Subject: Re: [Linux-ia64] Re: [patch] support 64 bit pci_alloc_consistent
Message-ID: <20030518172203.GA13855@cup.hp.com>
References: <16071.1892.811622.257847@trained-monkey.org> <1053250142.1300.8.camel@laptop.fenrus.com> <20030518.023533.98888328.davem@redhat.com> <20030518094341.A1709@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518094341.A1709@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 09:43:41AM +0000, Arjan van de Ven wrote:
> Most drivers will just say "look I
> can do THIS much. I don't give a flying fish about how much of
> that you actually use". At least in the probing code. 

The platform code needs a way to indicate the given mask will not work.
Rejecting proposals by the driver seems reasonable if the driver
only supports two different masks anyway (eg 64 and 32-bit).

In the case of a platform requiring 64-bit masks for consistent mappings,
the platform DMA code must reject proposals for non-64-bit DMA masks.
(eg PCI-X device implementing less than 64-bits)

In both cases the driver will care because it will crash the box otherwise.

grant
