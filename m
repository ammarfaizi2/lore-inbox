Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWCDWvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWCDWvU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWCDWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:51:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:8371 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932285AbWCDWvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:51:20 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
In-Reply-To: <17417.29372.744064.211813@cargo.ozlabs.ibm.com>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
	 <1141419966.3888.67.camel@localhost.localdomain>
	 <17417.29372.744064.211813@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 09:49:53 +1100
Message-Id: <1141512594.17127.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 21:58 +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > Actually, the ppc's full barrier (sync) will generate bus traffic, and I
> > think in some case eieio barriers can propagate to the chipset to
> > enforce ordering there too depending on some voodoo settings and wether
> > the storage space is cacheable or not.
> 
> Eieio has to go to the PCI host bridge because it is supposed to
> prevent write-combining, both in the host bridge and in the CPU.

That can be disabled with HID bits tho ;)

Ben.


