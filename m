Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTLGKBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 05:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTLGKBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 05:01:19 -0500
Received: from ca1.symonds.net ([66.92.42.136]:37504 "EHLO symonds.net")
	by vger.kernel.org with ESMTP id S264392AbTLGKBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 05:01:18 -0500
Message-ID: <049e01c3bca9$0eae8880$7a01a8c0@gandalf>
From: "Mark Symonds" <mark@symonds.net>
To: "Keith Owens" <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
References: <29654.1070788614@ocs3.intra.ocs.com.au>
Subject: Re: 2.4.23 hard lock, 100% reproducible. 
Date: Sun, 7 Dec 2003 02:01:17 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...]
> 
> addr2line requires compiling with -g.  You can also do
>   ksymoops -m /path/to/your/System.map -A c02363dd
> which does not require a recompile.
> 

Excellent, this is alot easier.  Should note that this 
kernel is compiled without support for loadable modules.
Here goes: 

------------- 

puggy:/usr/src/linux/2.4.23# ksymoops -m ./System.map -A c02363dd
ksymoops 2.4.9 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m ./System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod


Adhoc c02363dd <tcp_print_conntrack+2d/60>


1 error issued.  Results may not be reliable.
puggy:/usr/src/linux/2.4.23#

-------------

-- 
Mark

