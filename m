Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSIWSpp>; Mon, 23 Sep 2002 14:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSIWSnC>; Mon, 23 Sep 2002 14:43:02 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261320AbSIWSm2>;
	Mon, 23 Sep 2002 14:42:28 -0400
Subject: Re: 2.5.37 lockup with dbench 36 and make -j3 bzImage and PREEMPT=y.
From: Steven Cole <elenstev@mesatop.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020921120529.A20153@hh.idb.hist.no>
References: <1032555932.14946.225.camel@spc9.esa.lanl.gov> 
	<20020921120529.A20153@hh.idb.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Sep 2002 10:09:30 -0600
Message-Id: <1032797370.28405.5.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-21 at 04:05, Helge Hafting wrote:
> On 2002.09.20 23:05 Steven Cole wrote:
> > While running 2.5.37 with 36 dbench clients and doing a kernel compile
> > with make -j3 bzImage, my test machine locked up.  
> 
> 2.5.36 SMP no preempt locks up under similiar circumstances - a compile
> with make -j 3 and moderate disk activity on 2 scsi disks makes it
> freeze solid now and then.  Perhaps this is some sort of SMP problem
> also exposed by preempt?
> 
> I haven't tested this in 2.5.37 because refuses to run X.
> 
> Helge Hafting

Further testing with 2.5.37 over the weekend showed that the lockup also
occurred without preempt here too.

This seems to have been fixed in 2.5.38-mm2.  I've run up to dbench 128
while doing several kernel compiles with make -j3 with PREEMPT enabled,
and have not observed any lockups at all.

Steven

