Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTFGHNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTFGHNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:13:22 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:53006 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262687AbTFGHNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:13:18 -0400
Date: Sat, 7 Jun 2003 08:26:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607082651.A18894@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
	akpm@digeo.com, vojtech@suse.cz
References: <20030607063424.GA12616@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030607063424.GA12616@averell>; from ak@muc.de on Sat, Jun 07, 2003 at 08:34:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 08:34:24AM +0200, Andi Kleen wrote:
> 
> I finally got sick of seeing bug reports from people who did not enable
> CONFIG_VT or forgot to enable the obscure options for the keyboard
> driver. This is especially a big problem for people who do make oldconfig
> with a 2.4 configuration, but seems to happen in general often.
> I also included the PS/2 mouse driver. It is small enough and a useful
> fallback on any PC.
> 
> This patch wraps all this for i386/amd64 in CONFIG_EMBEDDED. If 
> CONFIG_EMBEDDED is not defined they are not visible and always enabled.

This sounds like a bad idea.  many modern PCs only have usb keyboard/mouse
these days.  Having them in defconfig is fine but we shouldn't obsfucate
the kernel config due to user stupidity.

