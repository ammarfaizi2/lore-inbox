Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUGFCGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUGFCGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 22:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGFCGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 22:06:47 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:26257 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262605AbUGFCGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 22:06:33 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org, benh@kernel.crashing.org
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data 
In-reply-to: Your message of "Mon, 05 Jul 2004 16:38:18 -0400."
             <20040705203818.GA11625@samarkand.rivenstone.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Jul 2004 12:06:08 +1000
Message-ID: <2970.1089079568@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2004 16:38:18 -0400, 
jhf@rivenstone.net (Joseph Fannin) wrote:
>On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
>
>  I'm getting this while building for ppc32:
>    Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS
>
>  This didn't happen with -mm5.
>
>  The help text for CONFIG_KALLSYMS_EXTRA_PASS says I should report a
>bug, and reads like kallsyms is a utility or part of the toolchain;
>I think it's talking about the kernel feature though, so I guess
>I'll report it here.  I'll keep this tree around in case any more
>information is needed.

Run these commands on the tree that needed CONFIG_KALLSYMS_EXTRA_PASS=y
(assumes Bourne shell)

for i in 1 2 3; do nm .tmp_kallsyms$i.o > .tmp_mapk$i; nm .tmp_vmlinux$i > .tmp_mapv$i; done
tar cjvf /var/tmp/kallsyms.tar.bz2 .tmp_kallsyms* .tmp_vmlinux* .tmp_map*

Send the tarball to me, not the list.

