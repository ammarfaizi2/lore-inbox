Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWF1Rrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWF1Rrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWF1Rrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:47:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18338 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751504AbWF1Rrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:47:42 -0400
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from
	Longhaul by rw semaphores
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: Rafa? Bilski <rafalbilski@interia.pl>, linux-kernel@vger.kernel.org,
       davej@redhat.com
In-Reply-To: <20060628173448.GA2371@suse.de>
References: <44A28AA2.6060306@interia.pl>  <20060628173448.GA2371@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 19:03:00 +0100
Message-Id: <1151517780.15166.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 10:34 -0700, ysgrifennodd Greg KH:
> Eeek!  You mean the longhaul driver can change the frequency of the PCI
> bus?  Oh, that's a recipe for disaster...

Not as I understand the docs, and that would be unfixable. Some C3
setups do however appear to "fall off the bus" during transitions which
means if BMDMA is active things get confused.

I am still not clear if this is just cache corruption through us not
listening or whether we genuinely need to halt. In the former case
flushing and disabling the CPU caches ought to be sufficient.

Alan

