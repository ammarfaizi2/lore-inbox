Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTAKM4H>; Sat, 11 Jan 2003 07:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbTAKM4H>; Sat, 11 Jan 2003 07:56:07 -0500
Received: from zamok.crans.org ([138.231.136.6]:33438 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S265939AbTAKM4F>;
	Sat, 11 Jan 2003 07:56:05 -0500
From: Bertrand VIEILLE <Bertrand.Vieille@crans.org>
To: Vincent Hanquez <tab@tuxfamily.org>
Subject: Re: 2.4.21-pre3-acX oops
Date: Sat, 11 Jan 2003 14:04:50 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030110222008$074c@gated-at.bofh.it> <6599015.32TDcXEdQ7@adelaide.crans.org> <20030111123504.GB7731@darwin.gaia.net>
In-Reply-To: <20030111123504.GB7731@darwin.gaia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200301111404.51086@adelaide.crans.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Saturday 11 January 2003 13:35, Vincent Hanquez a écrit :
> > EIP:    0010:[__free_pages_ok+637/672]    Tainted: P
>
> Your kernel is tainted with a proprietary module.
>
> >Process X (pid: 547, stackpage=f7257000)
>
> and this is related to X. (nvidia proprietary module ?)

Yes, NVdriver is loaded.

> Does this oops happen without the module ?

I don't have tested without this module (because I works a lot under X) but 
I also have had an oops with a non-X application (apt-get).
And Magnus Månsson doesn't have any proprietary module and he has the same 
problem.


printing eip:
c013172d
Oops: 0002
CPU:    0
EIP:    0010:[__free_pages_ok+637/672]    Tainted: P
EFLAGS: 00010246
eax: 00000000   ebx: c174f060   ecx: f1262000   edx: f126205c
esi: 00000000   edi: 00000000   ebp: 00000000   esp: f1263e40
ds: 0018   es: 0018   ss: 0018
Process apt-get (pid: 2125, stackpage=f1263000)
Stack: 00000001 00000282 e70413e0 e70413e0 e70413e0 c174f060 c013d99e 
e70413e0
f5a8c128 c174f060 00006827 c02d89a0 c01308df c174f060 000001d2 f1262000
00000200 000001d2 00000020 00000020 000001d2 00000020 00000006 c0130b23
Call Trace:    [try_to_free_buffers+142/272] [shrink_cache+543/784] 
[shrink_caches+99/160] [try_to_free_pages_zone+54/80] 
[balance_classzone+87/496]
[__alloc_pages+243/400] [generic_file_write+880/2016] 
[ext3_file_write+57/208] [sys_write+163/320] [system_call+51/56]

Code: 89 58 04 89 03 89 53 04 89 59 5c 89 7b 0c ff 41 68 eb bf 0f
<1>Unable to handle kernel NULL pointer dereference at virtual address 
00000004
printing eip:
c013172d
Oops: 0002
CPU:    0
EIP:    0010:[__free_pages_ok+637/672]    Tainted: P
EFLAGS: 00010246
eax: 00000000   ebx: c19b1470   ecx: f1262000   edx: f126205c
esi: 00000000   edi: 00000000   ebp: 00000000   esp: f1263c68
ds: 0018   es: 0018   ss: 0018
Process apt-get (pid: 2125, stackpage=f1263000)
Stack: 00000082 00000082 c03449b4 00000020 00000000 c01dbbd3 c03449b4 
0005879f
00000000 f720f1a8 00004000 00000001 c012788b c19b1470 00000001 c00bd178
c02ddfc0 08400000 f1260084 0806e000 00000000 c012607b f6a0bc00 f1260080
Call Trace:    [poke_blanked_console+83/112] [zap_pte_range+235/272] 
[zap_page_range+139/240] [exit_mmap+185/352] [mmput+71/160]
[do_exit+135/560] [die+114/128] [do_page_fault+676/1231] 
[do_get_write_access+692/1392] [journal_dirty_metadata+379/528] 
[do_get_write_access+692/1392]
[do_page_fault+0/1231] [error_code+52/60] [__free_pages_ok+637/672] 
[try_to_free_buffers+142/272] [shrink_cache+543/784] [shrink_caches+99/160]
[try_to_free_pages_zone+54/80] [balance_classzone+87/496] 
[__alloc_pages+243/400] [generic_file_write+880/2016] 
[ext3_file_write+57/208] [sys_write+163/320]
[system_call+51/56]

Code: 89 58 04 89 03 89 53 04 89 59 5c 89 7b 0c ff 41 68 eb bf 0f

Bertrand Vieille
