Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264713AbRGELWo>; Thu, 5 Jul 2001 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264717AbRGELWe>; Thu, 5 Jul 2001 07:22:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53254 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264652AbRGELWY>; Thu, 5 Jul 2001 07:22:24 -0400
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
To: helgehaf@idb.hist.no (Helge Hafting)
Date: Thu, 5 Jul 2001 12:21:42 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3B442354.BCA61010@idb.hist.no> from "Helge Hafting" at Jul 05, 2001 10:20:36 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I7CY-0002NT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But please don't make initrd mandatory for those of us who don't
> need ACPI, don't need dhcp before mounting disks and so on.
> 
> I hope the "fs-less" kernel image still will be possible for those
> of us who have a simple setup.

If we can do that kind of early boot user space then stuff like finding the
root file system and possibly even the initial pnpbios scanners belong in
user space. So you would want it for all boxes.

Equally you would want it to be completely trivial - it has to be a case of
a default make bzImage popping out a completely perfect base initrd and
make bzLilo adding both

