Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTETPym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTETPym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:54:42 -0400
Received: from [208.186.192.194] ([208.186.192.194]:7896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263825AbTETPyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:54:39 -0400
Message-Id: <200305201607.h4KG7XL21672@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: wacky hangs on 2.5.69-mm7, -mm3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 May 2003 09:07:33 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 
we are running a few tests on 2.5.69, -mm7, and -mm3 and having
some wacky hangs.

Booted both kernels with default IO scheduler. 

The Reaim test running against -mm7 (AIM rewrite) hangs, with a large number 
of 'sync' commands that never complete and are unkillable. (Various tests call 
'sync') System is a 4-CPU PIII , two of the CPU's are stuck at 100% iowait. 
Filesystem is ext2.  Same kernel run with elevator=deadline ran okay. -mm6 ran 
okay, but
was not especially performant. (separate mail)

The -mm3 kernel is running DBT2 on a 8-CPU machine, with raw devices. Ten 
minutes
into the run, all IO ceases, iostat shows devices 133% busy, workload stops.
'ps -aef' never completes. Previous run with elevator=noop was fine. 

We've left the 8-way as is if you want a look.
cliffw
maryedie
OSDL







