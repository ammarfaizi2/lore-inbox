Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSKMTSD>; Wed, 13 Nov 2002 14:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSKMTSD>; Wed, 13 Nov 2002 14:18:03 -0500
Received: from [198.149.18.6] ([198.149.18.6]:44007 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261292AbSKMTSC>;
	Wed, 13 Nov 2002 14:18:02 -0500
Subject: Re: [2.5.47] Unable to load XFS module
From: Stephen Lord <lord@sgi.com>
To: kronos@kronoz.cjb.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021113184805.GA777@dreamland.darkstar.net>
References: <20021113184805.GA777@dreamland.darkstar.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Nov 2002 13:19:20 -0600
Message-Id: <1037215162.1352.4.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 12:48, Kronos wrote:
> 
> Hi,
> I'm playing with kernel 2.5.47. XFS support is compiled as module and at
> boot time, while mounting /home, I get this:
> 
> insmod /lib/modules/2.5.47/kernel/fs/xfs/xfs.o failed
> 
> Then, trying to modprobe xfs by hand:
> 
> /lib/modules/2.5.47/kernel/fs/xfs/xfs.o: unresolved symbol page_states__per_cpu
> /lib/modules/2.5.47/kernel/fs/xfs/xfs.o: insmod /lib/modules/2.5.47/kernel/fs/xfs/xfs.o failed
> /lib/modules/2.5.47/kernel/fs/xfs/xfs.o: insmod xfs failed

If you turn off modversions it works, this appears to be an issue
with the per_cpu variables and how module versioning works with
them.

Steve



