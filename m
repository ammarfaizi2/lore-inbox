Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318696AbSIFOeZ>; Fri, 6 Sep 2002 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318704AbSIFOeZ>; Fri, 6 Sep 2002 10:34:25 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41156 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318696AbSIFOeY>; Fri, 6 Sep 2002 10:34:24 -0400
Subject: 0-order allocation failures in LTP run of Last nights bk tree
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Sep 2002 09:27:03 -0500
Message-Id: <1031322426.30394.4.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the nightly ltp run against the bk 2.5 tree last night I saw this
show up in the logs.

It happened on the 2-way PIII-550, 2gb physical ram, but not on the
smaller UP box I test on.

mtest01: page allocation failure. order:0, mode:0x50
mtest01: page allocation failure. order:0, mode:0x50
mtest01: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
mtest01: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
klogd: page allocation failure. order:0, mode:0x50
...
...

The past few nights it's been failing from compile errors such as the
vmlinux.lds.S error and such so I'm not for certain that this was caused
by something that got introduced yesterday.  It should be from something
pretty recent though.

Thanks,
Paul Larson

