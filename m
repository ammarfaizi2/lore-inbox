Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUAMOTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 09:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbUAMOTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 09:19:47 -0500
Received: from linux.us.dell.com ([143.166.224.162]:26861 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264313AbUAMOTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 09:19:44 -0500
Date: Tue, 13 Jan 2004 08:19:32 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Scott Long <scott_long@adaptec.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed Enhancements to MD
Message-ID: <20040113081932.A721@lists.us.dell.com>
References: <40036902.8080403@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40036902.8080403@adaptec.com>; from scott_long@adaptec.com on Mon, Jan 12, 2004 at 08:41:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 08:41:54PM -0700, Scott Long wrote:
> - DDF Metadata support: Future products will use the 'DDF' on-disk
>    metadata scheme.  These products will be bootable by the BIOS, but
>    must have DDF support in the OS.  This will plug into the abstraction
>    mentioned above.

For those unfamiliar with DDF (Disk Data Format), it is a Storage
Networking Industry Association (SNIA) project ("Common RAID DDF
TWG"), designed to provide a single metadata format to be used by all
the RAID vendors (hardware and software alike).  It removes vendor
lock-in by having a metadata format that all can use, thus in theory
you could move disks from an Adaptec hardware RAID controller to an
LSI software RAID solution without reformatting the disks or touching
your file systems in any way.  Dell has been championing the DDF
concept for quite a while, and is driving vendors from which we
purchase RAID solutions to use DDF instead of their own individual
metadata formats.

I haven't seen the spec yet myself, but I'm lead to believe that
DDF allows for multiple logical drives to be created across a single
set of disks (e.g. a 10GB RAID1 LD and a 140GB RAID0 LD together on
two 80GB spindles), as well as whole disks be used.  It has a
mechanism to support reconstruction checkpointing, so you don't have
to restart a reconstruct from the beginning after a reboot, but from
where you left off.  And other useful features too that you'd expect
in a common RAID solution.  

DDF is quickly becoming important to RAID and system vendors, and I
welcome Adaptec's work to implement DDF support on Linux.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
