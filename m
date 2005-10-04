Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVJDC7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVJDC7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVJDC7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:59:40 -0400
Received: from xenotime.net ([66.160.160.81]:52657 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932320AbVJDC7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:59:40 -0400
Date: Mon, 3 Oct 2005 19:59:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 - menuconfig: raid support wrong place?
Message-Id: <20051003195938.779fa982.rdunlap@xenotime.net>
In-Reply-To: <20051003083537.GB1746@schottelius.org>
References: <20051003083537.GB1746@schottelius.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005 10:35:37 +0200 Nico Schottelius wrote:

> Hello!
> 
> Is it wanted, that some hardware raids are listed below
> "Block devices" and not IDE or SCSI support?
> 
> And will SATA devices in general stay below SCSI?
> 
> Both things aren't really intuitive to find and I would expect
> the raid drivers below IDE or SCSI and I was searching for SATA
> not below SCSI some times.

Yeah, we sometimes tend to put drivers in a menu depending
on what technology or interfaces they use.
E.g., some RAID drivers are under Block Devices because they are
implemented as block devices.

That's probably not the best place for them from a user
perspective, but instead of putting them under IDE or SCSI
support, I would rather see them merged with the
Multi-device support menu (RAID and LVM), which appears
to be mostly for infrastructure, not for device drivers,
but there could be a separate section of it for device drivers
IMO.

SATA (currently) uses SCSI software interfaces, so it lives in the
SCSI menus.  Yes, that might not make sense to some people.
Maybe a separate menu for SATA would make sense...

Want to propose some changes via patches?  I have no idea how
well accepted they might be.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
