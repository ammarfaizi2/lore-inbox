Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVJaENY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVJaENY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 23:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVJaENY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 23:13:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751331AbVJaENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 23:13:23 -0500
Date: Sun, 30 Oct 2005 23:13:13 -0500
From: Dave Jones <davej@redhat.com>
To: Grant Coady <gcoady@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
Message-ID: <20051031041313.GA1939@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Grant Coady <gcoady@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200510290000.j9T00Bqd001135@hera.kernel.org> <20051031024217.GA25709@redhat.com> <436591A5.20609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436591A5.20609@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:38:13PM +1100, Grant Coady wrote:

 > > This patch is removing some PCI idents from drivers that are currently
 > > marked BROKEN on some/all architectures.  It seems counterproductive
 > > to create even more work to get those drivers fixed.
 > 
 > Nobody cares, the drivers are dying of bit-rot :)

Remove the BROKEN, and it builds, and runs just fine on most systems.
(Or it least it did, until this intentional breakage occured).

 > > Especially in the case of for eg, the advansys scsi driver, which
 > > actually works for some people, even though it isn't updated to use
 > > modern scsi layer interfaces.
 > 
 > Any positive suggestions?

Yes. Don't remove symbols that are referenced by code in the rest of the
tree (even if it isn't buildable).  It's not as though leaving those
symbols there breaks anything, or even bloats the kernel.

 > How many years does a driver remain broken before it gets removed?  These
 > drivers don't compile cleanly thus are not in use, no?  Perhaps a set of
 > patches scheduling removal is in order.

At least 2 distros are carrying patches removing the BROKEN attribute
on the advansys Kconfig for some architectures. The users of those kernels
using their advansys controllers without any issue at all.

Even if this were not the case, randomly removing bits of a driver so that
it has no chance of working isn't how we schedule removal. 

		Dave

