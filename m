Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbSJKPXt>; Fri, 11 Oct 2002 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262498AbSJKPXt>; Fri, 11 Oct 2002 11:23:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262497AbSJKPXs>;
	Fri, 11 Oct 2002 11:23:48 -0400
Date: Fri, 11 Oct 2002 08:27:59 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Steven Dake <scd@broked.org>
cc: <linux-kernel@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>
Subject: Re: [PATCH] [RFC] Advanced TCA Disk Hotswap support in Linux Kernel
 [core 1/2]
In-Reply-To: <004401c270c4$4bbe2a50$0200000a@persist>
Message-ID: <Pine.LNX.4.33L2.0210110814340.8007-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Oct 2002, Steven Dake wrote:

| I am developing the Linux kernel support required to support Advanced
| TCA
| (PICMG 3.0) architecture.  Advanced TCA is a technology where boards
| exist
| in a chassis and can either be processor nodes or storage nodes.  All
| blades in the chassis are connected by FibreChannel and Ethernet.  The
| blades can be hot added or hot removed while the Linux processor nodes
| are
| active, meaning that the SCSI subsystem must add devices on insertion
| requests and remove devices on ejection requests.
|
| The following is the first public patch that I am posting that adds
| support
| for SCSI and FibreChannel hotswap via a programmatic kernel interface,
| as well as userland access via ioctls.

Thanks for letting us know about it.
Does this project have a web page?

| The second patch is a FibreChannel driver that is modified to support
| SCSI hotswap.
|
| This mechanism is far superior to /proc/scsi/scsi because it:
| 1) provides true FibreChannel hotswap support (at this point qlogic FC
| HBAs)
| 2) is programmatic such that errors can be reported from kernel to user
|    without looking is /var/log/.

so where does someone look for errors?

| 3) Provides superior response times vs opening a file and writing to
| proc.
| 4) Easier to control from kernel and user via C APIs vs using
| open/write.

Does this suggest adding yet another hotswap/hotplug mechanism
to Linux?  It would be a good thing to unify them IMHO.

Does this hotswap mechanism require userspace software to activate it?
If so, is it available or being developed also?

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.


