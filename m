Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbUBXE7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbUBXE7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:59:53 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43417 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262167AbUBXE7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:59:42 -0500
Subject: Re: Intel vs AMD x86-64
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077590524.8084.237.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Feb 2004 21:42:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> Linus Torvalds <torvalds@osdl.org> wrote:

>> In fact, I _think_ you could actually use the AGP bridge as a strange
>> IOMMU. Of course, right now their AGP bridges are all 32-bit limited
>> anyway, but the point being that they at least in theory would seem to
>> have the capability to do this.
>
> Ok, I see.  In fact, I remember some vague notion that the AGP bridge
> on the Athlon's could technically be used as a full-on IOMMU, especially
> since it was all derived from Alpha PCI chipsets which did use things
> this way.

This is exactly the way it works. The AGP bridge is
a replicated per-CPU thing, along with the memory.
Good boards have a BIOS option marked "Linux only"
that lets you choose an IO-MMU window size ranging
from 32 MB to 2 GB. Direct your 32-bit PCI DMA
into that window and you get an IO-MMU.

Memory can be interleaved across the CPUs or not,
on 4 kB boundries. It's a BIOS option, though some
insane code could be written to change the setting.
Setting up only one of the IO-MMUs would be neat.



