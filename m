Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVDNUpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVDNUpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDNUoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:44:17 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:65209 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261555AbVDNUnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:43:55 -0400
Subject: Re: spurious 8259A interrupt: IRQ7
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113498693.18871.11.camel@mindpipe>
References: <1113498693.18871.11.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 14:43:46 -0600
Message-Id: <1113511426.22496.43.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 13:11 -0400, Lee Revell wrote:
> I get this message occasionally on both my machines.  I googled and saw
> some references to this message on 2.4 but nothing for 2.6.  Some of the
> references were to APIC, which I don't have enabled.
> 
> Both machines are using VIA chipsets and display the "VIA IRQ fixup"
> message on boot.  I think this behavior started about the same time that
> message started to appear.

The VIA IRQ fixup in 2.6.11 is broken.  It works for some, but
not all boxes with VIA hardware.

There's a fix in 2.6.12-rc2-mm3.  Actually, I doubt that it will
help you, though -- the 2.6.11 breakage is such that some machines
that need the fixup don't get it (and don't print the "VIA IRQ
fixup message").

