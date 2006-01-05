Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752282AbWAEWsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbWAEWsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWAEWsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:48:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752282AbWAEWsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:48:00 -0500
Date: Thu, 5 Jan 2006 14:47:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       reiserfs-dev@namesys.com, Dave Airlie <airlied@linux.ie>,
       "Vladimir V. Saveliev" <vs@namesys.com>
Subject: Re: Re. 2.6.15-mm1
Message-Id: <20060105144720.25085afa.akpm@osdl.org>
In-Reply-To: <200601051801.29007@zodiac.zodiac.dnsalias.org>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> wrote:
>
> Hi,
> 
> just tried 2.6.15-mm1 on my thinkpad. Various aspects that didn't work / look 
> good:

Thanks.  A few people have some work to do before they are ready to merge to 2.6.16.

> Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
> Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
> Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
> Jan  5 16:22:39 t40 last message repeated 10 times
> Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices

pnpacpi is unhappy.

> All over the place logs like this:
> Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer: f7db5502 
> Type 07 Len 0
> Unknown to me so far..

acpi is unhappy.

> When X startet, the laptops crashed:
> Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]: disable_write_barrier 
> (fs/reiser4/wander.c:233)[zam-1055]:
> Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier

Vladimir, is that expected?

> Jan  5 16:22:43 t40 kernel:
> Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing 
> 0xe0000000,0x4000000
> Jan  5 16:22:48 t40 last message repeated 2 times

Is that new?

> Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at 
> 0000:00:00.0.
> Jan  5 16:22:48 t40 kernel: c028b7cf
> Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev cfq_iosched 
> ehci_hcd uhci_hcd
> Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
> Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)
> Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000 
> c19720ec 00000000 1f000217 c1a79400
> Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262 
> c1a79400 c02972af 1f000207 c029727f

hm, it's not clear what oopsed.   Can you get a cleaner copy of this?

> Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1 0

drm is unhappy

