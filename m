Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVGJTEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVGJTEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVGJTEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:04:15 -0400
Received: from isilmar.linta.de ([213.239.214.66]:21943 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261158AbVGJTDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:03:24 -0400
Date: Sun, 10 Jul 2005 20:46:49 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 vs. /sbin/cardmgr
Message-ID: <20050710184649.GG8758@dominikbrodowski.de>
Mail-Followup-To: Bob Tracy <rct@gherkin.frus.com>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20050709051217.A4F0FDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709051217.A4F0FDBA1@gherkin.frus.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
> I've got a Mandrake 10.0 system with a 2.6.12 kernel presently.
> Somewhere between 2.6.11 and 2.6.12, /sbin/cardmgr from the
> pcmcia-cs-3.2.5-3mdk package decided it needs to consume incredible
> amounts of CPU time when invoked the first time following a boot.
> You can definitely notice the load on the system.
> 
> Stopping cardmgr requires a "kill -9": softer kills are ignored.
> Restarting cardmgr produces the following output:
> 
> cardmgr[3731]: watching 2 sockets
> cardmgr[3731]: could not adjust resource: IO ports 0xc00-0xcff: Device or resource busy
> cardmgr[3731]: could not adjust resource: IO ports 0x100-0x4ff: Device or resource busy
> cardmgr[3731]: could not adjust resource: memory 0xc0000-0xfffff: Input/output error
> cardmgr[3731]: could not adjust resource: memory 0x60000000-0x60ffffff: Input/output error
> cardmgr[3731]: could not adjust resource: memory 0xa0000000-0xa0ffffff: Input/output error
> cardmgr[3731]: could not adjust resource: IO ports 0x1000-0x1fff: Device or resource busy
> cardmgr[3731]: could not adjust resource: IO ports 0xa00-0xaff: Device or resource busy
> 
> But at least it doesn't seem to be running around in tight circles at
> this point :-).
> 
> System is a Dell Latitude CPxJ notebook that continues to work fine
> with 2.6.11 and older kernels.  Any idea what changed between 2.6.11
> and 2.6.12 that might be causing this problem?  I can probably provide
> more info on request.

Please post the output of "lspci" and "lsmod" as I'd like to know which
kind of PCMCIA bridge is in your notebook.

	Dominik
