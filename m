Return-Path: <linux-kernel-owner+w=401wt.eu-S932164AbWLNJad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWLNJad (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWLNJac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:30:32 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:16290 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbWLNJac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:30:32 -0500
Date: Thu, 14 Dec 2006 11:30:28 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214093028.GF6674@rhun.haifa.ibm.com>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <20061213203113.GA9026@suse.de> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org> <Pine.LNX.4.64.0612131306460.5718@woody.osdl.org> <1166044547.27217.902.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166044547.27217.902.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 10:15:47PM +0100, Arjan van de Ven wrote:

> with DRI you have the case where "something" needs to do security
> validation of the commands that are sent to the card. (to avoid a
> non-privileged user to DMA all over your memory)

We also have the interesting case where your card is behind an
isolation-capable IOMMU, so if you let userspace program it, you need
a userspace-accessible DMA-API for IOMMU mappings (or to pre-map
everything in the IOMMU, which loses on some of the benefits of
isolation-capable IOMMUs (i.e., only map what you need to use right
now)).

Cheers,
Muli
