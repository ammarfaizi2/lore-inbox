Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbTGPDD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbTGPDD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:03:59 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17539 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S270094AbTGPDD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:03:57 -0400
Date: Tue, 15 Jul 2003 22:47:32 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030715224732.GA31942@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com> <20030704121124.GB12633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704121124.GB12633@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:11:24PM +0200, Adrian Bunk wrote:
> On Thu, Jul 03, 2003 at 07:03:04PM +0000, Adam Belay wrote:
> > Some of my recent patches may correct this issue.  If not, it may be
> > an unresolvable resource conflict.  Try catting
>
> the dmesg output looks better, but it still doesn't work:

Hi Adrian,

Sorry for the delayed response.

> Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> request_module: failed /sbin/modprobe -- snd-card-0. error = -16specify port
> pnp: the driver 'ad1816a' has been registered
> pnp: match found with the PnP device '01:01.00' and the driver 'ad1816a'
> pnp: match found with the PnP device '01:01.01' and the driver 'ad1816a'
> pnp: Device 01:01.00 activated.
> pnp: Device 01:01.01 activated.
> ALSA device list:
>   No soundcards found.
>
> <--  snip  -->
>
> This problem is hopefully not unresolvable, the card works fine
> with ISAPNP with both kernel 2.4 and kernel 2.5 <= 2.5.72 .

Because activation was successful, it looks like its a bug instead of a
conflict.

>
> # cat /sys/bus/pnp/devices/01\:01.01/options

> # cat /sys/bus/pnp/devices/01\:01.01/resources

Could I see the output for 01:01.00/options and 01:01.00/resources also,
perhaps it will provide some insight.  I'm guessing the resources may be
incorrect in that node.

Thanks,
Adam
