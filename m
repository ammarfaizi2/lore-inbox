Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUIOMnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUIOMnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIOMnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:43:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6290 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264997AbUIOMnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:43:33 -0400
Date: Wed, 15 Sep 2004 08:21:02 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marcin Ro?ek <marcin.rozek@ios.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c
Message-ID: <20040915112102.GA1992@logos.cnet>
References: <414834AA.70602@ios.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414834AA.70602@ios.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:25:14PM +0200, Marcin Ro?ek wrote:
> Hi,
> here's what i can see in syslog (Mandrake 10 Official with kernel 2.4.27 
> and grsecurity patch)
> 
> kernel: kernel BUG at page_alloc.c:144!
> kernel: invalid operand: 0000
> kernel: CPU:    1
> kernel: EIP:    0010:[__free_pages_ok+82/784]    Not tainted
> kernel: EIP:    0010:[<c01d4a62>]    Not tainted
> kernel: EFLAGS: 00010286
> kernel: eax: 00000000   ebx: c13ae7e8   ecx: c13ae7e8   edx: 00000000
> kernel: esi: 00000008   edi: 00000000   ebp: c01037c0   esp: c2fdfe3c
> kernel: ds: 0018   es: 0018   ss: 0018
> kernel: Process smbd (pid: 30808, stackpage=c2fdf000)
> kernel: Stack: c01d48ff 00000000 00141000 c1149a9c c1149a9c c01d5ad8 
> c01037c0 00141100
> kernel:        dfe8dbf0 00000002 00000008 00141000 de305160 c01c6ff0 
> 00141100 c2fdfe7c
> kernel:        00001411 00000000 00141000 dd9490c0 c01c715f 00141000 
> 86838614 26838614
> kernel: Call Trace:    [rw_swap_page+63/96] [read_swap_cache_async+104/199] 
> [swapin_readahead+48/112] [do_swap_page+303/368] [handle_mm_fault+385/608]
> kernel: Call Trace:    [<c01d48ff>] [<c01d5ad8>] [<c01c6ff0>] [<c01c715f>] 
> [<c01c76a1>]
> kernel:   [do_page_fault+1264/1856] [generic_file_write+276/352] 
> [ext3_file_write+57/192] [sys_write+279/368] [do_page_fault+0/1856] 
> [error_code+52/64]
> kernel:   [<c01b0d90>] [<c01ce6c4>] [<c020d659>] [<c01dd027>] [<c01b08a0>] 
> [<c01a2304>]
> kernel:
> kernel: Code: 0f 0b 90 00 28 76 3b c0 8b 35 90 14 16 c0 89 d8 29 f0 c1 f8

Its the third or fourth report like this I see, all of them with the 
grsecurity patch applied.

Have you tried a stock 2.4.27?
