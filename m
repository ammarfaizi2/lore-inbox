Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269538AbUJWBXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbUJWBXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269424AbUJWBVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:21:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:51683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269683AbUJWAc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:32:57 -0400
Date: Fri, 22 Oct 2004 17:32:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Add mecanism to check existence of legacy ISA
 devices
In-Reply-To: <1098490981.11740.109.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410221730560.2101@ppc970.osdl.org>
References: <1098490981.11740.109.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> This patch adds an arch function that can be overriden by the various
> platforms at runtime, to query if a given legacy IO device actually
> exist on the platform (based on the standard base port).

Ehh..

Why don't you use the "isapnp" or "acpi" interfaces?

Yeah yeah, you don't actually have isapnp on your system. But like it or 
not, when we talk ISA enumeration, there is an existing standard for doing 
it. And since the drivers involved don't actually do BIOS calls or 
anything like that, they don't need to know that your "acpi" or "isapnp" 
enumeration comes from ppc64 firmware..

		Linus
