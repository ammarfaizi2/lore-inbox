Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268474AbRG3LDX>; Mon, 30 Jul 2001 07:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268477AbRG3LDN>; Mon, 30 Jul 2001 07:03:13 -0400
Received: from ns.caldera.de ([212.34.180.1]:21927 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268474AbRG3LC7>;
	Mon, 30 Jul 2001 07:02:59 -0400
Date: Mon, 30 Jul 2001 13:03:01 +0200
Message-Id: <200107301103.f6UB31e20045@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: thierry@cri74.org (Thierry Laronde), linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010730113319.A24939@pc04.cri.cur-archamps.fr> you wrote:
> Please note that in the following, these are remarks _not_ bad criticism.
> Maybe what is found by the script could be of some interest to people
> coordinating the source writing.

> GOAL
> ----

> In order to allow a kind of light detection of hardware to be use during
> installation, I wanted to build a database (for PCI: I start with the
> easiest...) with the following format:

> CLASS_ID	VENDOR_ID	DEVICE_ID	driver_name

> I have decided to write a script (you will find all the stuff attached)
> parsing the Linux kernel sources in order to do that.

Well, that was what I did 2 years ago for Caldera ;)

Howevery this is no longer needed.

Nearly all PCI kernel modules now export the ids they match for in the
MODULE_DEVICE_TABLE, for PCI, ISAPNP and USB.

So either read it from /lib/modules/<kernelver>/modules.*map, or 
use the modutils code that extracts this information from the
.o files itself.

You need to compile those, but you usually do that anyway for a kernel
build.

Ciao, Marcus
