Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTLUUts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 15:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTLUUts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 15:49:48 -0500
Received: from intra.cyclades.com ([64.186.161.6]:15530 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263927AbTLUUtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 15:49:43 -0500
Date: Sun, 21 Dec 2003 18:45:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Octave <oles@ovh.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
In-Reply-To: <20031221191431.GP25043@ovh.net>
Message-ID: <Pine.LNX.4.58L.0312211832320.6632@logos.cnet>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local>
 <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net>
 <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net>
 <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2146005474-1072038856=:6632"
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-2146005474-1072038856=:6632
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Sun, 21 Dec 2003, Octave wrote:

> > Octave,
> >
> > Can you please "echo 1 > /proc/sys/vm_gfp_debug" (to turn VM debugging on)
> > and rerun the tests which crash the box.
> >
> > Also run "vmstat 5" in the background and save that to a file.
> >
>
> Marcelo,
>
> I got this kernel panic:
>
> Dec 21 20:04:34 stock kernel: e9f01e50 c012e1d8 000001d2 08451094 00000001 e7493ea0 0000040e 00000000
> Dec 21 20:04:34 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80
> Dec 21 20:04:34 stock kernel:        00104025 c01225a3 e7493ea0 08451094 00000001 e9efec60 f7ec5380 c01226bf
> Dec 21 20:04:34 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
> Dec 21 20:04:34 stock kernel:   [<c0111707>] [<c011157c>] [<c0123db0>] [<c0122d85>] [<c0106fa0>]
> Dec 21 20:04:52 stock kernel: f7313e18 c012e1d8 000001d2 f770c184 00000020 f7f0ffe0 0000040e 00000000
> Dec 21 20:04:52 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80
> Dec 21 20:04:52 stock kernel:        00000012 c0124e80 00000007 00000020 0000004a f717e920 f717e920 c0124efe
> Dec 21 20:04:52 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c0124e80>] [<c0124efe>] [<c0126793>]
> Dec 21 20:04:52 stock kernel:   [<c01226e5>] [<c01228e8>] [<c0111707>] [<c011157c>] [<c019047c>] [<c0135190>]
> Dec 21 20:04:52 stock kernel:   [<c0106fa0>]
> Dec 21 20:05:01 stock kernel: dba23e50 c012e1d8 000001d2 094de03c 00000001 e6461500 0000040e 00000000
> Dec 21 20:05:01 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80
> Dec 21 20:05:01 stock kernel:        00104025 c01225a3 e6461500 094de03c 00000001 c23eea80 c10e6f90 c01226bf
> Dec 21 20:05:01 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
> Dec 21 20:05:01 stock kernel:   [<c0111707>] [<c011157c>] [<c0123db0>] [<c0122d85>] [<c0106fa0>]
> Dec 21 20:05:42 stock kernel: c8525e50 c012e1d8 000001d2 08cb90f4 00000001 e14a2f20 0000040e 00000000
> Dec 21 20:05:42 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80
> Dec 21 20:05:42 stock kernel:        00104025 c01225a3 e14a2f20 08cb90f4 00000001 df9fc420 c138dbc0 c01226bf
> Dec 21 20:05:42 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
> Dec 21 20:05:42 stock kernel:   [<c0111707>] [<c011157c>] [<c0123db0>] [<c0122d85>] [<c0106fa0>]
> Dec 21 20:05:42 stock kernel: d70ebedc c012e1d8 000001d2 00000000 00000000 f71aa544 00000414 00000000
> Dec 21 20:05:42 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80
> Dec 21 20:05:42 stock kernel:        00000000 c012595a 00000000 ffffffea f71b0ba0 00000000 f7fb29cc 00001000
> Dec 21 20:05:42 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c012595a>] [<c0125f1a>] [<c0125d9c>]
> Dec 21 20:05:42 stock kernel:   [<c0135126>] [<c0106eb7>]
> Dec 21 20:05:42 stock kernel: e3e97edc c012e1d8 000001d2 00000000 00000000 f71aa544 00000414 00000000
> Dec 21 20:05:42 stock kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80
> Dec 21 20:05:42 stock kernel:        00000000 c012595a 00000000 ffffffea f6ee63c0 00000000 f7fb31f4 00001000
> Dec 21 20:05:42 stock kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c012595a>] [<c0125f1a>] [<c0125d9c>]
> Dec 21 20:05:42 stock kernel:   [<c0135126>] [<c0106eb7>]
> Warning (Oops_read): Code line not seen, dumping what data is available

Octave,

This is not a kernel panic, its the VM debugging output.

Can you please apply the attached patch on top of 2.4.23 and rerun the
test with "echo 1 > /proc/sys/vm_gfp_debug" ?

It will printout the number of available swap pages when processes get
killed.

Thanks

> Trace; c012e1d8 <__alloc_pages+2a4/2b0>
> Trace; c012dd80 <_alloc_pages+18/1c>
> Trace; c01225a3 <do_anonymous_page+3b/124>
> Trace; c01226bf <do_no_page+33/200>
> Trace; c01228e8 <handle_mm_fault+5c/b8>
> Trace; c0111707 <do_page_fault+18b/4cd>
> Trace; c011157c <do_page_fault+0/4cd>
> Trace; c0123db0 <do_brk+130/230>
> Trace; c0122d85 <sys_brk+c1/f0>
> Trace; c0106fa0 <error_code+34/3c>
> Trace; c012e1d8 <__alloc_pages+2a4/2b0>
> Trace; c012dd80 <_alloc_pages+18/1c>
> Trace; c0124e80 <page_cache_read+7c/d0>
> Trace; c0124efe <read_cluster_nonblocking+2a/40>
> Trace; c0126793 <filemap_nopage+13f/23c>
> Trace; c01226e5 <do_no_page+59/200>
> Trace; c01228e8 <handle_mm_fault+5c/b8>
> Trace; c0111707 <do_page_fault+18b/4cd>
> Trace; c011157c <do_page_fault+0/4cd>
> Trace; c019047c <tty_read+dc/124>
> Trace; c0135190 <sys_read+100/108>
> Trace; c0106fa0 <error_code+34/3c>
> Trace; c012e1d8 <__alloc_pages+2a4/2b0>
> Trace; c012dd80 <_alloc_pages+18/1c>
> Trace; c01225a3 <do_anonymous_page+3b/124>
> Trace; c01226bf <do_no_page+33/200>
> Trace; c01228e8 <handle_mm_fault+5c/b8>
> Trace; c0111707 <do_page_fault+18b/4cd>
> Trace; c011157c <do_page_fault+0/4cd>
> Trace; c0123db0 <do_brk+130/230>
> Trace; c0122d85 <sys_brk+c1/f0>
> Trace; c0106fa0 <error_code+34/3c>
> Trace; c012e1d8 <__alloc_pages+2a4/2b0>
> Trace; c012dd80 <_alloc_pages+18/1c>
> Trace; c01225a3 <do_anonymous_page+3b/124>
> Trace; c01226bf <do_no_page+33/200>
> Trace; c01228e8 <handle_mm_fault+5c/b8>
> Trace; c0111707 <do_page_fault+18b/4cd>
> Trace; c011157c <do_page_fault+0/4cd>
> Trace; c0123db0 <do_brk+130/230>
> Trace; c0122d85 <sys_brk+c1/f0>
> Trace; c0106fa0 <error_code+34/3c>
> Trace; c012e1d8 <__alloc_pages+2a4/2b0>
> Trace; c012dd80 <_alloc_pages+18/1c>
> Trace; c012595a <do_generic_file_read+356/488>
> Trace; c0125f1a <generic_file_read+96/198>
> Trace; c0125d9c <file_read_actor+0/e8>
> Trace; c0135126 <sys_read+96/108>
> Trace; c0106eb7 <system_call+2f/34>
> Trace; c012e1d8 <__alloc_pages+2a4/2b0>
> Trace; c012dd80 <_alloc_pages+18/1c>
> Trace; c012595a <do_generic_file_read+356/488>
> Trace; c0125f1a <generic_file_read+96/198>
> Trace; c0125d9c <file_read_actor+0/e8>
> Trace; c0135126 <sys_read+96/108>
> Trace; c0106eb7 <system_call+2f/34>
>
>
--8323328-2146005474-1072038856=:6632
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="page_alloc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58L.0312211834160.6632@logos.cnet>
Content-Description: 
Content-Disposition: attachment; filename="page_alloc.patch"

LS0tIGxpbnV4LTIuNC4yMy9tbS9wYWdlX2FsbG9jLmMub3JpZwkyMDAzLTEy
LTIxIDE3OjU0OjM3LjAwMDAwMDAwMCAtMDIwMA0KKysrIGxpbnV4LTIuNC4y
My9tbS9wYWdlX2FsbG9jLmMJMjAwMy0xMi0yMSAxNzo1Mzo1OS4wMDAwMDAw
MDAgLTAyMDANCkBAIC00MzYsOCArNDM2LDEwIEBADQogIG91dDoNCiAJcHJp
bnRrKEtFUk5fTk9USUNFICJfX2FsbG9jX3BhZ2VzOiAldS1vcmRlciBhbGxv
Y2F0aW9uIGZhaWxlZCAoZ2ZwPTB4JXgvJWkpXG4iLA0KIAkgICAgICAgb3Jk
ZXIsIGdmcF9tYXNrLCAhIShjdXJyZW50LT5mbGFncyAmIFBGX01FTUFMTE9D
KSk7DQotCWlmICh1bmxpa2VseSh2bV9nZnBfZGVidWcpKQ0KKwlpZiAodW5s
aWtlbHkodm1fZ2ZwX2RlYnVnKSkgew0KKwkJcHJpbnRrKEtFUk5fRVJSICJP
T006IG5yX3N3YXBfcGFnZXM9JWQiLCBucl9zd2FwX3BhZ2VzKTsNCiAJCWR1
bXBfc3RhY2soKTsNCisJfQ0KIAlyZXR1cm4gTlVMTDsNCiB9DQogDQo=

--8323328-2146005474-1072038856=:6632--
