Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUGEThJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUGEThJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUGEThI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:37:08 -0400
Received: from pra69-d108.gd.dial-up.cz ([193.85.69.108]:59520 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S261234AbUGEThD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:37:03 -0400
Date: Mon, 5 Jul 2004 21:35:38 +0200
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: register dump when press scroll lock
Message-ID: <20040705193538.GA23211@penguin.localdomain>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FF669@hdsmsx403.hd.intel.com> <1089055122.15671.65.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089055122.15671.65.camel@dhcppc4>
User-Agent: Mutt/1.5.6+20040523i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 03:18:42PM -0400, Len Brown wrote:
> On Sat, 2004-07-03 at 06:25, Marcel Sebek wrote:
> > I run 2.6.7 kernel.
> > 
> > Steps to reproduce:
> > Switch keyboard by "Pause/Break" key from English to Czech map (or
> > another
> > second keymap, I also tried Slovak). Then press scrolllock. The
> > following
> > is printed out and scrlock led state is untouched:
> > 
> > Pid: 0, comm:              swapper
> > EIP: 0060:[<c01e5382>] CPU: 0
> > EIP is at acpi_processor_idle+0xd4/0x1c7
> >  EFLAGS: 00000212    Not tainted  (2.6.7)
> > EAX: 00cf9366 EBX: 00004008 ECX: 00cf90da EDX: 00004008
> > ESI: cffd28b0 EDI: c0467e80 EBP: cffd2800 DS: 007b ES: 007b
> > CR0: 8005003b CR2: 080b7f40 CR3: 0ca85000 CR4: 000002d0
> >  [<c0101f3c>] cpu_idle+0x2c/0x40
> >  [<c043d5fc>] start_kernel+0x13c/0x160
> >  [<c043d370>] unknown_bootoption+0x0/0x110
> > 
> > EIP is at c01e5382 or c01e5361. Here is the asm code from gdb:
> > 
> > 0xc01e5355 <acpi_processor_idle+167>:   cmp    $0x3,%eax
> > 0xc01e5358 <acpi_processor_idle+170>:   je     0xc01e539f
> > <acpi_processor_idle+241>
> ...
> You're in the ACPI idle loop, which is normal.
> 
> Why it prints this stuff out is probably
> answered someplace in the CONFIG_MAGIC_SYSRQ code.
> 

I originally thought that it's something like OOPS and missed that it's
printed by sysrq :-).

Sorry for the noise.

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

