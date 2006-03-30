Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWC3Abu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWC3Abu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWC3Abt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:31:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47597 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751300AbWC3Abb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:31:31 -0500
Message-ID: <442B26E1.7000204@pobox.com>
Date: Wed, 29 Mar 2006 19:31:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Simplex and other mode filtering logic
References: <1143482300.4970.65.camel@localhost.localdomain>
In-Reply-To: <1143482300.4970.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Add a field to the host_set called 'flags' (was host_set_flags changed
> to suit Jeff)
> Add a simplex_claimed field so we can remember who owns the DMA channel
> Add a ->mode_filter() hook to allow drivers to filter modes
> Add docs for mode_filter and set_mode
> Filter according to simplex state
> Filter cable in core
> 
> This provides the needed framework to support all the mode rules found
> in the PATA world. The simplex filter deals with 'to spec' simplex DMA
> systems found in older chips. The cable filter avoids duplicating the
> same rules in each chip driver with PATA. Finally the mode filter is
> neccessary because drive/chip combinations have errata that forbid
> certain modes with some drives or types of ATA object.
> 
> Drive speed setup remains per channel for now and the filters now use
> the framework Tejun put into place which cleans them up a lot from the
> older libata-pata patches.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


