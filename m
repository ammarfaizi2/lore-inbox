Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTLUTQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTLUTQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:16:24 -0500
Received: from ping.ovh.net ([213.186.33.13]:31161 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S263890AbTLUTQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:16:14 -0500
Date: Sun, 21 Dec 2003 20:14:31 +0100
From: Octave <oles@ovh.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221191431.GP25043@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312211643470.6632@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Octave,
> 
> Can you please "echo 1 > /proc/sys/vm_gfp_debug" (to turn VM debugging on)
> and rerun the tests which crash the box.
> 
> Also run "vmstat 5" in the background and save that to a file.
> 

Marcelo,

I got this kernel panic:

Dec 21 20:04:34 stock kernel: e9f01e50 c012e1d8 000001d2 08451094 00000001 e7493ea0 0000040e 00000000 
Dec 21 20:04:34 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 21 20:04:34 stock kernel:        00104025 c01225a3 e7493ea0 08451094 00000001 e9efec60 f7ec5380 c01226bf 
Dec 21 20:04:34 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
Dec 21 20:04:34 stock kernel:   [<c0111707>] [<c011157c>] [<c0123db0>] [<c0122d85>] [<c0106fa0>]
Dec 21 20:04:52 stock kernel: f7313e18 c012e1d8 000001d2 f770c184 00000020 f7f0ffe0 0000040e 00000000 
Dec 21 20:04:52 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 21 20:04:52 stock kernel:        00000012 c0124e80 00000007 00000020 0000004a f717e920 f717e920 c0124efe 
Dec 21 20:04:52 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c0124e80>] [<c0124efe>] [<c0126793>]
Dec 21 20:04:52 stock kernel:   [<c01226e5>] [<c01228e8>] [<c0111707>] [<c011157c>] [<c019047c>] [<c0135190>]
Dec 21 20:04:52 stock kernel:   [<c0106fa0>]
Dec 21 20:05:01 stock kernel: dba23e50 c012e1d8 000001d2 094de03c 00000001 e6461500 0000040e 00000000 
Dec 21 20:05:01 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 21 20:05:01 stock kernel:        00104025 c01225a3 e6461500 094de03c 00000001 c23eea80 c10e6f90 c01226bf 
Dec 21 20:05:01 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
Dec 21 20:05:01 stock kernel:   [<c0111707>] [<c011157c>] [<c0123db0>] [<c0122d85>] [<c0106fa0>]
Dec 21 20:05:42 stock kernel: c8525e50 c012e1d8 000001d2 08cb90f4 00000001 e14a2f20 0000040e 00000000 
Dec 21 20:05:42 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 21 20:05:42 stock kernel:        00104025 c01225a3 e14a2f20 08cb90f4 00000001 df9fc420 c138dbc0 c01226bf 
Dec 21 20:05:42 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
Dec 21 20:05:42 stock kernel:   [<c0111707>] [<c011157c>] [<c0123db0>] [<c0122d85>] [<c0106fa0>]
Dec 21 20:05:42 stock kernel: d70ebedc c012e1d8 000001d2 00000000 00000000 f71aa544 00000414 00000000 
Dec 21 20:05:42 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 21 20:05:42 stock kernel:        00000000 c012595a 00000000 ffffffea f71b0ba0 00000000 f7fb29cc 00001000 
Dec 21 20:05:42 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c012595a>] [<c0125f1a>] [<c0125d9c>]
Dec 21 20:05:42 stock kernel:   [<c0135126>] [<c0106eb7>]
Dec 21 20:05:42 stock kernel: e3e97edc c012e1d8 000001d2 00000000 00000000 f71aa544 00000414 00000000 
Dec 21 20:05:42 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 21 20:05:42 stock kernel:        00000000 c012595a 00000000 ffffffea f6ee63c0 00000000 f7fb31f4 00001000 
Dec 21 20:05:42 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c012595a>] [<c0125f1a>] [<c0125d9c>]
Dec 21 20:05:42 stock kernel:   [<c0135126>] [<c0106eb7>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c012e1d8 <__alloc_pages+2a4/2b0>
Trace; c012dd80 <_alloc_pages+18/1c>
Trace; c01225a3 <do_anonymous_page+3b/124>
Trace; c01226bf <do_no_page+33/200>
Trace; c01228e8 <handle_mm_fault+5c/b8>
Trace; c0111707 <do_page_fault+18b/4cd>
Trace; c011157c <do_page_fault+0/4cd>
Trace; c0123db0 <do_brk+130/230>
Trace; c0122d85 <sys_brk+c1/f0>
Trace; c0106fa0 <error_code+34/3c>
Trace; c012e1d8 <__alloc_pages+2a4/2b0>
Trace; c012dd80 <_alloc_pages+18/1c>
Trace; c0124e80 <page_cache_read+7c/d0>
Trace; c0124efe <read_cluster_nonblocking+2a/40>
Trace; c0126793 <filemap_nopage+13f/23c>
Trace; c01226e5 <do_no_page+59/200>
Trace; c01228e8 <handle_mm_fault+5c/b8>
Trace; c0111707 <do_page_fault+18b/4cd>
Trace; c011157c <do_page_fault+0/4cd>
Trace; c019047c <tty_read+dc/124>
Trace; c0135190 <sys_read+100/108>
Trace; c0106fa0 <error_code+34/3c>
Trace; c012e1d8 <__alloc_pages+2a4/2b0>
Trace; c012dd80 <_alloc_pages+18/1c>
Trace; c01225a3 <do_anonymous_page+3b/124>
Trace; c01226bf <do_no_page+33/200>
Trace; c01228e8 <handle_mm_fault+5c/b8>
Trace; c0111707 <do_page_fault+18b/4cd>
Trace; c011157c <do_page_fault+0/4cd>
Trace; c0123db0 <do_brk+130/230>
Trace; c0122d85 <sys_brk+c1/f0>
Trace; c0106fa0 <error_code+34/3c>
Trace; c012e1d8 <__alloc_pages+2a4/2b0>
Trace; c012dd80 <_alloc_pages+18/1c>
Trace; c01225a3 <do_anonymous_page+3b/124>
Trace; c01226bf <do_no_page+33/200>
Trace; c01228e8 <handle_mm_fault+5c/b8>
Trace; c0111707 <do_page_fault+18b/4cd>
Trace; c011157c <do_page_fault+0/4cd>
Trace; c0123db0 <do_brk+130/230>
Trace; c0122d85 <sys_brk+c1/f0>
Trace; c0106fa0 <error_code+34/3c>
Trace; c012e1d8 <__alloc_pages+2a4/2b0>
Trace; c012dd80 <_alloc_pages+18/1c>
Trace; c012595a <do_generic_file_read+356/488>
Trace; c0125f1a <generic_file_read+96/198>
Trace; c0125d9c <file_read_actor+0/e8>
Trace; c0135126 <sys_read+96/108>
Trace; c0106eb7 <system_call+2f/34>
Trace; c012e1d8 <__alloc_pages+2a4/2b0>
Trace; c012dd80 <_alloc_pages+18/1c>
Trace; c012595a <do_generic_file_read+356/488>
Trace; c0125f1a <generic_file_read+96/198>
Trace; c0125d9c <file_read_actor+0/e8>
Trace; c0135126 <sys_read+96/108>
Trace; c0106eb7 <system_call+2f/34>



