Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWJDAHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWJDAHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWJDAHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:07:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5870 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030418AbWJDAHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:07:43 -0400
Subject: Re: System hang problem.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manish Neema <Manish.Neema@synopsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5A0@US01WEMBX1.internal.synopsys.com>
References: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5A0@US01WEMBX1.internal.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 01:33:14 +0100
Message-Id: <1159921995.17553.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 15:07 -0700, ysgrifennodd Manish Neema:
> RHEL3.0 U3 would generate an OOM kill "each and every time" it sensed
> system hang but due to other bugs, we had to move away from it. RedHat

And often when it didn't need too which for many users workloads is bad

> Changing overcommit to 2 (and ratio to any where from 1 to 99) would
> result in certain OS processes (automount daemon for e.g.) getting
> killed when all the allowed memory is committed. What is the point in

Killed and logging an OOM message ? That indicates a bug (well for ratio
<= about 50% anyway). Killed because there is no memory and a memory
allocation fails is expected.

> reserving some memory if a random root process would get killed leaving
> the system in a totally unknown state?

If you run out of memory and someone asks for more something has to
give. A properly configured system really shouldn't be running out of
memory anyway for most sane workloads.

It's like putting water in a bottle, at the point you have more water
than bottle something has to spill, if it doesn't the box hangs.

Alan

