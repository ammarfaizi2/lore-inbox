Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSJUW1U>; Mon, 21 Oct 2002 18:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSJUW1U>; Mon, 21 Oct 2002 18:27:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8253 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262076AbSJUW1S>; Mon, 21 Oct 2002 18:27:18 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210212233.g9LMXAG14311@devserv.devel.redhat.com>
Subject: Re: 2.5.44 compile problem: MegaRAID driver
To: dledford@redhat.com (Doug Ledford)
Date: Mon, 21 Oct 2002 18:33:10 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Matt_Domsch@dell.com,
       andmike@us.ibm.com, cliffw@osdl.org,
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
       linux-megaraid-devel@dell.com
In-Reply-To: <20021021222500.GK28914@redhat.com> from "Doug Ledford" at Oct 21, 2002 06:25:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is, umm, a non-elegant way of handling things once you switch your 
> driver to the new PCI driver probe model :-(

Someone has to fix all the problems with the new probe model first. Like
the fact we don't have any meaningful address space locking or
sane refcounting for the scsi objects. Until that happens its not a relevant
discussion IMHO

When you can answer "what lock prevents my address space being reissued
before all memory/I/O has provably completely" and "at what point can I
free my scsi structures on a hot unplug safely for all situations" then
its worth discussion
