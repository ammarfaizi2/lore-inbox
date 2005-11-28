Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVK1WgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVK1WgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVK1WgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:36:25 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:10219 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932257AbVK1WgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:36:25 -0500
Date: Mon, 28 Nov 2005 17:36:23 -0500
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Too many disks in system? (RAID5)
Message-ID: <20051128223623.GA3803@csclub.uwaterloo.ca>
References: <20051128222558.GN2529@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128222558.GN2529@mail.muni.cz>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 11:25:58PM +0100, Lukas Hejtmanek wrote:
> Hello,
> 
> I have system with attached SATA array which contains 24 disks. I wanted to run
> software RAID 5, but 24 disks means, that I would need /dev/sda to /dev/sdx
> devices with major 8 and last minor 384. Minor seems to be limited to 8 bits.
> Is there any chance to run software array using all 24 disks?
> 
> My test was with mknod v. 5.2.1 and kernel 2.6.14.3

Major 8 is not the only scsi major.  Look at devices.txt in the kernel
Documentation dir.  MAKEDEV also usually knows how to make more scsi
devices.  For example major 65.  Just use MAKEDEV /dev/sdx and see what
it creates.

Len Sorensen
