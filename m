Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVB1HkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVB1HkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVB1HkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:40:12 -0500
Received: from isilmar.linta.de ([213.239.214.66]:31911 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261175AbVB1HkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:40:06 -0500
Date: Mon, 28 Feb 2005 08:40:05 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: unsupported PCI PM caps (again?)
Message-ID: <20050228074005.GA2915@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Christian Kujau <evil@g-house.de>, linux-kernel@vger.kernel.org,
	dhowells@redhat.com
References: <42226647.4040000@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42226647.4040000@g-house.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 01:31:03AM +0100, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> hi,
> 
> i'm running 2.6.11-rc2-bk10 and still get my syslog clobbered with
> messages like this:
> 
> PCI: 0000:00:0c.0 has unsupported PM cap regs version (1)
> 
> $ lspci | grep 0000:00:0c.0
> 0000:00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
> [Cyclone] (rev 30)
> 
> so everytime i "use" my eth0, a few more messages appear. 2.6.11-rc2-bk10
> was released on Feb 2 i think, but "bk changes" reveals:
> 
> ChangeSet@1.1966.62.6, 2005-01-14 15:58:36-08:00, dhowells@redhat.com
>   [PATCH] PCI: Downgrade printk that complains about unsupported PCI PM
>           caps
> 
> my network card is working fine, what can i do to disable these messages?
> i am NOT using APM or ACPI.

As the "unsupported PCI PM cap regs version (1)" handling caused trouble on
some devices, it got removed in 2.6.11-rc5.

	Dominik
