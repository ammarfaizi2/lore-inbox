Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWCGSuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWCGSuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWCGSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:50:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:25789 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751156AbWCGSuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:50:07 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, ak@suse.de,
       mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603071024550.3573@g5.osdl.org>
References: <5041.1141417027@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
	 <32518.1141401780@warthog.cambridge.redhat.com>
	 <1146.1141404346@warthog.cambridge.redhat.com>
	 <31420.1141753019@warthog.cambridge.redhat.com>
	 <1141755496.31814.56.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603071024550.3573@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Mar 2006 18:55:06 +0000
Message-Id: <1141757706.31814.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 10:28 -0800, Linus Torvalds wrote:
> x86 tends to serialize PIO too much (I think at least Intel CPU's will 
> actually wait for the PIO write to be acknowledged by _something_ on the 
> bus, although it obviously can't wait for the device to have acted on it).

Don't bet on that 8(

In the PCI case the I/O write appears to be acked by the bridges used on
x86 when the write completes on the PCI bus and then back to the CPU.
MMIO is thankfully posted. At least thats how the timings on some
devices look.



