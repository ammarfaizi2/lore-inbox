Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131130AbRBVWDj>; Thu, 22 Feb 2001 17:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbRBVWDa>; Thu, 22 Feb 2001 17:03:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130609AbRBVWDS>;
	Thu, 22 Feb 2001 17:03:18 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102222159.f1MLxb031306@flint.arm.linux.org.uk>
Subject: Re: nfs_refresh_inode: inode number mismatch
To: samcconn@cotw.com (Scott A McConnell)
Date: Thu, 22 Feb 2001 21:59:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A9592F4.FFCC2236@cotw.com> from "Scott A McConnell" at Feb 22, 2001 02:30:12 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott A McConnell writes:
> I am running  RedHat Linux version 2.2.16-3 on  my PC and  Hardhat Linux
> version 2.4.0-test5 on my MIPS board. Any thoughts or suggestions?
> 
> I saw a discussion start on the ARM list along these lines but I never
> saw a solution.

The problem is partly caused by the NFS server indefinitely caching NFS
request XIDs to responses, and the NFS client not having a way to generate
a random initial XID.  (thus, for each reboot, it starts at the same XID
number).

Upgrade your NFS server to kernel 2.2.18, and don't reboot more than once
in a 2 minute window.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

