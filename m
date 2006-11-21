Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031267AbWKUSWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031267AbWKUSWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031268AbWKUSWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:22:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40407 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031267AbWKUSWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:22:14 -0500
Date: Tue, 21 Nov 2006 18:27:26 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Ray Lee <ray-lk@madrabbit.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
Message-ID: <20061121182726.7d31451f@localhost.localdomain>
In-Reply-To: <200611211746.39173.ak@suse.de>
References: <455B63EC.8070704@madrabbit.org>
	<p73psbhay8n.fsf@bingen.suse.de>
	<45632B30.9090506@lwfinger.net>
	<200611211746.39173.ak@suse.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 17:46:39 +0100
Andi Kleen <ak@suse.de> wrote:

> 
> > Shouldn't this problem be mentioned somewhere in the documentation, or did I miss something?

The documentation is correct, the implementation is broken. The
documented behaviour works for all platforms except one whose maintainer
has a problem with it and refuses to follow the spec.
 
> Possibly, but devices that cannot address at least 4GB are normally
> categorized as "hardware bugs" (or less polite descriptions) and those don't 
> tend to get much airtime in documentation.

The rest of the kernel deals with hardware limitations, 30bit DMA works
on the other platforms. This is an x86-64 platform problem. It
misimplements the basic pci_ functionality. If it doesn't wish to
implement the stuff (and there btw Andi I do think your view has
considerable merit) it should fail the set_mask requests.

Alan
