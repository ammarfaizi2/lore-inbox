Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTDNOvQ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTDNOvQ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:51:16 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:29319 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S263411AbTDNOvO (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 10:51:14 -0400
Date: Mon, 14 Apr 2003 16:03:32 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: linux-kernel@vger.kernel.org
Subject: olarge -- force O_LARGEFILE on app binaries.
Message-ID: <Pine.LNX.4.44.0304141554560.3687-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some time ago I was annoyed to see that ghostscript didn't support large
files (>2G) and, although the fix to gs(1) was trivial it was very
undesirable to have to recompile it (for lots of reasons like mismatch
between the source set and fonts, libraries etc). So the only (efficient)
solution in my case would have been to "modify" the behaviour of the gs
binary without rebuilding it. One way is to use LD_PRELOAD feature but I
found it easier to just knock up a simple kernel module olarge.o to do the
job.

In case someone else encountered the same problem and needed the solution 
(but didn't know how to write it), here it is for download:

http://www.moses.uklinux.net/patches/olarge.tar.gz

Regards
Tigran

PS. (for those familiar with sys_call_table[] handling in modules this 
should be obvious but just in case --- don't try to unload the module 
while "using it", i.e. running an app you have thus modified.)

PPS. Don't bother explaining to me that this is "not a nice thing to do 
inside a module", I am well aware of it. This is just a quick fix to a 
specific problem and I share with others who may have hit it as well, 
that's all. As the GPL license says "no assumed useability for any 
purpose...." :) Enjoy.

