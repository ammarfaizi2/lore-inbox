Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTJTQc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbTJTQc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:32:56 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:32455 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262547AbTJTQcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:32:54 -0400
Subject: Re: 2.6.0-test8-mm1
From: Jonathan Brown <jbrown@emergence.uk.net>
To: Antonio Dolcetta <adolcetta@infracom.it>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20031020170029.578b1b7a.adolcetta@infracom.it>
References: <20031020020558.16d2a776.akpm@osdl.org>
	 <1066656160.4180.3.camel@localhost>
	 <20031020170029.578b1b7a.adolcetta@infracom.it>
Content-Type: text/plain
Message-Id: <1066667523.4244.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 17:32:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I compiled radeonfb as a module and got this error:


WARNING:
/lib/modules/2.6.0-test8-mm1/kernel/drivers/video/aty/radeonfb.ko needs
unknown symbol release_console_sem

so the module wont load. I presume you are compiling in radeonfb?

I'm running this on an IBM X31 laptop and it works great on
2.6.0-test7-mm1, except temporary screen corruption when radeonfb loads:

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=14400 from BIOS
radeonfb: probed DDR SGRAM 16384k videoram
radeon_get_moninfo: bios 4 scratch = 1000044
radeonfb: panel ID string: 1024x768
radeonfb: detected DFP panel size from BIOS: 1024x768
radeonfb: ATI Radeon M6 LY DDR SGRAM 16 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END


On Mon, 2003-10-20 at 16:00, Antonio Dolcetta wrote:

> 
> Working perfectly here with radeon 9000
> 
> I start it without passing any option to the kernel and it guesses the
> correct resolution from BIOS (laptop)
> 
> radeonfb_pci_register BEGIN
> radeonfb: probed DDR SGRAM 65536k videoram
> radeonfb: Invalid ROM signature 0 should be 0xaa55
> radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults
> Starting monitor auto detection...
> Non-DDC laptop panel detected
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: Asssuming panel size 1400x1050
> radeonfb: ATI Radeon Lf Mobility M9 DDR SGRAM 64 MB
> radeonfb_pci_register END
> 
> 
> this is actually the first time the radeon framebuffer has worked for me
> that's great!
-- 
Jonathan Brown
http://emergence.uk.net/


