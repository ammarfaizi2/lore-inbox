Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbTBFVmb>; Thu, 6 Feb 2003 16:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTBFVma>; Thu, 6 Feb 2003 16:42:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:7889 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267454AbTBFVm2>;
	Thu, 6 Feb 2003 16:42:28 -0500
Date: Thu, 6 Feb 2003 13:51:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: 2.5.59 OOPS w/ fdisk & devfs
Message-Id: <20030206135138.3c083007.akpm@digeo.com>
In-Reply-To: <3E42D05E.8080907@blue-labs.org>
References: <3E42D05E.8080907@blue-labs.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 21:51:50.0762 (UTC) FILETIME=[F44F64A0:01C2CE29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+cert@blue-labs.org> wrote:
>
> Unable to handle kernel paging request at virtual address 6b6b6b87
> ...
> EIP is at _devfs_unhook+0x2b/0x70


Look.  devfs is sick.  Richard has disappeared.  Al did some work on it and
also disappeared.  Adam laid it on the ground and drove a truck over it, and
I had that patch in -mm for two or three weeks and had one single, sole, sad,
sorry report from a tester.

I dropped Adam's patch out again because it might have been implicated in
weird system hangs.

So what are we to do?  It appears that kernel developers do not use devfs,
and people who _do_ use devfs either did not test Adam's patch, or forgot to
send in a report.

I shall reinclude Adam's patch.  Will people who use devfs *please* test it,
and send in a report?  Otherwise the whole thing is just going nowhere.
