Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUBYJe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUBYJe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:34:26 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62216 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262580AbUBYJeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:34:25 -0500
Message-ID: <403C7D4D.1040104@aitel.hist.no>
Date: Wed, 25 Feb 2004 11:47:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 sometimes freeze on "sync"
References: <20040222172200.1d6bdfae.akpm@osdl.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.3-mm3 (and 2.6.3-mm1) occationally freeze on "sync".
They will run fine for several days, but if I do a sync
they might freeze completely and sysrq+B is the only action
that gets any response after that.  The mouse stops, the
x clock stops, and so on.

I only saw this once in mm1, and thought it might be some
glitch.  But it have happened several times with mm3,
so I'm reporting it.  It even hapopened when I ran sync
immediately after boot+login (in X) just to test.

I use the ext2 filesystem on two IDE drives.  The
root fs is ext2 on a RAID-1 on the same two drives.
I also mount nfs, but no nfs was mounted when I did
the "sync after boot+login" test.

This is the IDE controller, from lspci:
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
I also have proc, tmpfs, devpts and sysfs mounted.

The machine is single-cpu, the kernel is compiled without
preempt and with register arguments and frame pointer,
using gcc 3.3.3 from debian testing.

There obviously were no logs after this freeze.

Helge Hafting

