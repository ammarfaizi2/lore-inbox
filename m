Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131524AbRCNTqh>; Wed, 14 Mar 2001 14:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRCNTq1>; Wed, 14 Mar 2001 14:46:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131524AbRCNTqW>; Wed, 14 Mar 2001 14:46:22 -0500
Date: Wed, 14 Mar 2001 14:44:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Lars Kellogg-Stedman <lars@larsshack.org>
cc: Christoph Hellwig <hch@caldera.de>, John Jasen <jjasen1@umbc.edu>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>
Message-ID: <Pine.LNX.3.95.1010314143853.1825A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Lars Kellogg-Stedman wrote:

> > Put LABEL=<label set with e2label> in you fstab in place of the device name.
> 
> Which is great, for filesystems that support labels.  Unfortunately,
> this isn't universally available -- for instance, you cannot mount
> a swap partition by label or uuid, so it is not possible to completely
> isolate yourself from the problems of disk device renumbering.
> 
> -- Lars
> 
> -- 
> Lars Kellogg-Stedman <lars@larsshack.org>
> 
When my BIOS finds IDE disks, it starts at the lowest address of
the port. It then looks for the first master, then the slave(s), etc.
Then it tries the second, etc.

When my SCSI BIOS finds disks, it starts at the first controller,
the first LUN, the first drive, etc.

This used to even be the way disks were located by the kernel
drivers. Now, these are found in some "random" order.

If whatever is causing the "random" order was fixed, put back like
it used to be, etc., we wouldn't have these problems.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


