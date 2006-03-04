Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWCDK6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWCDK6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 05:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCDK6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 05:58:14 -0500
Received: from ozlabs.org ([203.10.76.45]:64697 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750753AbWCDK6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 05:58:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17417.29372.744064.211813@cargo.ozlabs.ibm.com>
Date: Sat, 4 Mar 2006 21:58:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <1141419966.3888.67.camel@localhost.localdomain>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
	<1141419966.3888.67.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> Actually, the ppc's full barrier (sync) will generate bus traffic, and I
> think in some case eieio barriers can propagate to the chipset to
> enforce ordering there too depending on some voodoo settings and wether
> the storage space is cacheable or not.

Eieio has to go to the PCI host bridge because it is supposed to
prevent write-combining, both in the host bridge and in the CPU.

Paul.
