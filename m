Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVAZNwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVAZNwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVAZNwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:52:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:25809 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262297AbVAZNwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:52:35 -0500
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16887.27336.161685.55774@alkaid.it.uu.se>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	 <1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	 <16885.13185.849070.479328@alkaid.it.uu.se>
	 <1106623515.6244.11.camel@gaston> <16886.2489.823835.17801@alkaid.it.uu.se>
	 <1106696846.6250.20.camel@gaston>
	 <16887.27336.161685.55774@alkaid.it.uu.se>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 00:51:25 +1100
Message-Id: <1106747485.5235.68.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 11:02 +0100, Mikael Pettersson wrote:
> Benjamin Herrenschmidt writes:
>  > On Tue, 2005-01-25 at 09:56 +0100, Mikael Pettersson wrote:
>  > 
>  > > On the eMac:
>  > > /proc/sys/kernel/powersave-nap exists and contains "0".
>  > > /proc/device-tree/cpus/PowerPC,G4/flush-on-lock exists as an empty file.
>  > 
>  > Ok, that is weird... so for some reason, Apple decided not to allow the
>  > eMac to do NAP mode, and thus to power manage the CPU when idle...
> 
> I assumed it was due to the UniNorth issue that pmac_feature.c mentions.

Not clear. I would expect the eMac to run with a fairly recent revision
of UniNorth with no issue, and since it's not an SMP machine there
should be no problem...

On the other hand, I also suspect that the whole NAP thing does have a
small impact on performances, so that may be the reason they chose not
to do it on this HW...

Ben.


