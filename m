Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbUA1XUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUA1XUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:20:36 -0500
Received: from post.tau.ac.il ([132.66.16.11]:21142 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S266077AbUA1XUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:20:32 -0500
Date: Thu, 29 Jan 2004 01:16:33 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Cc: Adam Belay <ambx1@neo.rr.com>, Micha Feigin <michf@post.tau.ac.il>
Subject: Re: PNP depends on ISA ? (2.6.2-rc2
Message-ID: <20040128231633.GF3975@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Adam Belay <ambx1@neo.rr.com>, Micha Feigin <michf@post.tau.ac.il>
References: <20040126193144.GC2004@luna.mooo.com> <20040126161746.GA3180@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20040126161746.GA3180@neo.rr.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.51; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 26, 2004 at 04:17:46PM +0000, Adam Belay wrote:
> On Mon, Jan 26, 2004 at 09:31:44PM +0200, Micha Feigin wrote:
> > I was wondering why pnp depends on isa being selected in 2.6.2-rc2, is
> > pnp really only relevant to isa? What happens with pci etc. ?
> > This may explain why using pnpbios locks up my machine (at least as of 2.6.0-test9).
> 
> Yes, it only is related to isa devices, but they include onboard devices
> such as serial ports.  It will, however, prevent resource conflicts
> between pci and system devices, especially with unusual configurations.
> Does using pnpbios cause your machine to lockup at boot?  If so, around
> where does it occur?  DMI information would also be useful for blacklisting
> purposes.
> 

I just checked again with 2.6.2-rc2. It occurs right after pnpbios
starts up. I wrote the oops down by hand since the computer went into a
hard lockup (no sysrq key), but couldn't get any results out of
ksymoops for some reason (maybe I am misusing it, any way to disable
pnpbios on a kernel compiled with so I can run it from the running
kernel?).
I attached the oops log and the dmi data (didn't know what is needed of
it).

> Thanks,
> Adam
> 

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dump.txt"

pnpbios: scanning system for pnpbios support ...
pnpbios: found pnp bios instellation structure at 0xc00f7760
pnpbios: pnp bios version 1.0, entry 0xf0000:0xaad2, dseg 0x400
general protection fault: 0000 [#1]
cpu: 0
eip: 0098:[<00003fb8>] not tainted
eflags: 00010082
eip is at 3fb8
[...]
process swapper (pid: 1, threadinfo=cffa8000 task=cffa38c0)
stack: 00001002 0002000f 556a0000 8d350000 541c0000 8d2fc65c c64d0c40 0000005a
       9e829e96 00008d2e 020b000f 0000bade 9231cc70 cc70c520 003fcbad 00010000
       67df0000 0007c020 02120000 1f0e0000 50000000 0000c129 ff380000 0246c037
call trace:

code: bad eip value
 <0> kernel panic: attempted to kill init!
--5vNYLRcllDrimb99
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmi_data.bz2"
Content-Transfer-Encoding: base64

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

--5vNYLRcllDrimb99--
