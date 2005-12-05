Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVLEVvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVLEVvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVLEVvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:51:13 -0500
Received: from web34104.mail.mud.yahoo.com ([66.163.178.102]:39071 "HELO
	web34104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964813AbVLEVvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:51:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kmwCR8DA2gLMLd5kzyHVNsLsMGlRUkKO88qKTS45LxoMC/cki5G/DOzKuekrQKqR7VFVkJCzKEIJk2O7nfi9+jMTpVZLwEV3LsPafn5o7bsC7snNPTK3/uMxGHmqaK6Ajk/awNrX7ac27zaYIH3jkysqQew6hewgShNIhvnS9Ck=  ;
Message-ID: <20051205215110.88112.qmail@web34104.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 13:51:10 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1133817536.12393.21.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1860124575-1133819470=:87387"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1860124575-1133819470=:87387
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> nr_unstable is not going to be set for non-NFS filesystems. 'unstable'
> is a caching state in which pages have been written out to the NFS
> server, but the server has not yet flushed the data to disk.

The NetApp always seems to return stable writes (even when the request are not).

Either way, I ran the system under minimal user mode (i.e. init=/bin/bash), to try to cut down on
the superfluous processes (cron, ntp, etc..).

I ran the test again.. same general result.
The tesr program is unkillable - even with sysrq's.

-Kenny



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
--0-1860124575-1133819470=:87387
Content-Type: text/x-log; name="sysrq.log"
Content-Description: 3165733884-sysrq.log
Content-Disposition: inline; filename="sysrq.log"

root@(none):/mnt/src# ./writetest -m /mnt/foo
pwrite to 200000  2097152
wrote 100352k 98M bytes in 1133800490.814289 seconds -> 0.000000M/sec
wrote 137216k 134M bytes in 1.000662 seconds -> 140.416228M/sec
wrote 143360k 140M bytes in 1.021878 seconds -> 143.657697M/sec
wrote 126976k 124M bytes in 0.993586 seconds -> 130.862778M/sec
wrote 141312k 138M bytes in 1.006713 seconds -> 143.738571M/sec
wrote 145408k 142M bytes in 0.980652 seconds -> 151.835505M/sec
wrote 112640k 110M bytes in 1.034777 seconds -> 111.466876M/sec
wrote 139264k 136M bytes in 0.967575 seconds -> 147.385304M/sec
wrote 106496k 104M bytes in 1.010874 seconds -> 107.878830M/sec
wrote 137216k 134M bytes in 0.990759 seconds -> 141.819740M/sec
wrote 124928k 122M bytes in 1.005555 seconds -> 127.219567M/sec
wrote 133120k 130M bytes in 1.016719 seconds -> 134.073308M/sec
wrote 129024k 126M bytes in 1.017694 seconds -> 129.823479M/sec
wrote 122880k 120M bytes in 0.963566 seconds -> 130.586924M/sec
wrote 102400k 100M bytes in 1.000683 seconds -> 104.786031M/sec
wrote 90112k 88M bytes in 1.083051 seconds -> 85.198839M/sec
[  744.911172] SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
[  748.595938] SysRq : Show Regs
[  748.599109] 
[  748.600699] Pid: 0, comm:              swapper
[  748.605363] EIP: 0060:[<c0100d4f>] CPU: 0
[  748.609578] EIP is at default_idle+0x36/0x56
[  748.614896]  EFLAGS: 00000246    Not tainted  (2.6.15-rc5+nfs+k2)
[  748.621274] EAX: 00000000 EBX: c0503000 ECX: c220e2e0 EDX: c0503000
[  748.627837] ESI: c053c380 EDI: c053c300 EBP: c0503fac DS: 007b ES: 007b
[  748.634804] CR0: 8005003b CR2: b7afd000 CR3: 00540000 CR4: 000006d0
[  751.044910] SysRq : Show State
[  751.048172] 
[  751.048173]                                                sibling
[  751.056232]   task             PC      pid father child younger older
[  751.062974] bash          S 00000001     0     1      0     2               (NOTLB)
[  751.071296] c2331f08 c2331ef8 00000004 00000001 00000044 c21fd780 c04938a8 000200d2 
[  751.079518]        c2330a70 c2331eec c013f968 000200d2 00000000 c04938a8 00000044 0000000e 
[  751.088650]        c21fd780 00000010 c2217560 00000001 0000391a 0183f473 000000a6 c2330550 
[  751.097780] Call Trace:
[  751.100597]  [<c011fa57>] do_wait+0x18a/0x376
[  751.105258]  [<c011fd03>] sys_wait4+0x3e/0x42
[  751.109918]  [<c011fd2e>] sys_waitpid+0x27/0x2b
[  751.114760]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  751.120145] migration/0   S 00000002     0     2      1             3       (L-TLB)
[  751.128365] c2339f94 c2339f84 00000004 00000002 c0116b9c c2337a70 c22275a8 00000001 
[  751.136510]        c220f5ac 00000001 00000073 c220f958 c220f958 c22275a8 c220f5a8 00000000 
[  751.145590]        c2227560 00000003 c220f560 00000000 000017c2 aa8db191 000000a9 c048db40 
[  751.154653] Call Trace:
[  751.157435]  [<c0118d0c>] migration_thread+0x81/0x10d
[  751.162753]  [<c012fe68>] kthread+0xb7/0xbc
[  751.167179]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.172584] ksoftirqd/0   S 00000000     0     3      1             4     2 (L-TLB)
[  751.180802] c233af98 c2337030 c220f560 00000000 000004db 000e078d 00000000 c233ba70 
[  751.188926]        c2337030 c233715c 00000001 c2331f5c c2330a70 ffffffff c2337030 c233af6c 
[  751.197945]        00000000 00000000 c220f560 00000000 000002b2 000ea053 00000000 c2330a70 
[  751.206965] Call Trace:
[  751.209747]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  751.214350]  [<c012fe68>] kthread+0xb7/0xbc
[  751.218774]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.224179] migration/1   S 00000001     0     4      1             5     3 (L-TLB)
[  751.232400] c233cf94 c233cf80 00000004 00000001 00000082 00000001 c233cf44 00000000 
[  751.240522]        c048db40 c2337a70 00000003 c2227560 c2330a70 00000009 00000008 c2330a70 
[  751.249542]        00000000 c2217ec0 c2217560 00000001 00000eaf 3827d003 000000a1 c2330a70 
[  751.258563] Call Trace:
[  751.261344]  [<c0118d0c>] migration_thread+0x81/0x10d
[  751.266661]  [<c012fe68>] kthread+0xb7/0xbc
[  751.271085]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.276490] ksoftirqd/1   S 00000001     0     5      1             6     4 (L-TLB)
[  751.284710] c2345f98 c2345f88 00000004 00000001 000000c7 00180089 00000000 c233b550 
[  751.292832]        c233b550 c2330a70 00000001 c2331f28 c2345000 ffffffff c233b550 c2345f6c 
[  751.301852]        c0407ed4 c22175a8 c2217560 00000001 00000177 2fc9a4b5 00000000 c2330550 
[  751.310872] Call Trace:
[  751.313654]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  751.318257]  [<c012fe68>] kthread+0xb7/0xbc
[  751.322680]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.328085] migration/2   S 00000004     0     6      1             7     5 (L-TLB)
[  751.336306] c2346f94 c2346f80 00000004 00000004 00000082 c2330550 c22175a8 00000000 
[  751.344427]        c2337a70 c2330550 00000001 c2217560 f7e79030 00000002 00000002 f7e79030 
[  751.353447]        00000000 c221fec0 c221f560 00000002 00000c37 37d42ab3 00000058 f7e79030 
[  751.362469] Call Trace:
[  751.365251]  [<c0118d0c>] migration_thread+0x81/0x10d
[  751.370568]  [<c012fe68>] kthread+0xb7/0xbc
[  751.374993]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.380399] ksoftirqd/2   S 00000002     0     7      1             8     6 (L-TLB)
[  751.388618] c234df98 c234ca70 c221f560 00000002 00000163 00275526 00000000 c234ca70 
[  751.396740]        c234ca70 c234cb9c 00000001 c2331f28 c234d000 ffffffff c234ca70 c234df6c 
[  751.405760]        c0407ed4 c221f5a8 c221f560 00000002 00000043 00275786 00000000 c2330030 
[  751.414781] Call Trace:
[  751.417562]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  751.422165]  [<c012fe68>] kthread+0xb7/0xbc
[  751.426590]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.431995] migration/3   S 00000003     0     8      1             9     7 (L-TLB)
[  751.440214] c234ef94 c234ef80 00000004 00000003 00000082 00000001 c234ef44 00000000 
[  751.448336]        c2330030 c2330550 00000001 c2217560 f70f8030 00000011 00000002 f70f8030 
[  751.457359]        00000000 c2227ec0 c2227560 00000003 0000105f 353ed25e 00000058 f70f8030 
[  751.466380] Call Trace:
[  751.469162]  [<c0118d0c>] migration_thread+0x81/0x10d
[  751.474479]  [<c012fe68>] kthread+0xb7/0xbc
[  751.478903]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.484309] ksoftirqd/3   S 00000003     0     9      1            10     8 (L-TLB)
[  751.492530] c2353f98 c2353f88 00000004 00000003 000000c9 00367434 00000000 c234c030 
[  751.500654]        c234c030 c2361550 00000001 c2331f28 c2353000 ffffffff c234c030 c2353f6c 
[  751.509673]        c0407ed4 c22275a8 c2227560 00000003 00000182 364e7604 00000058 c2337a70 
[  751.518694] Call Trace:
[  751.521476]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  751.526078]  [<c012fe68>] kthread+0xb7/0xbc
[  751.530502]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.535907] events/0      R running     0    10      1            11     9 (L-TLB)
[  751.544036] events/1      S 00000001     0    11      1            12    10 (L-TLB)
[  751.552256] c236af34 c236af24 00000004 00000001 00000202 00000001 c2354540 000007d0 
[  751.560377]        c236aef4 c012bb5c c22191b8 0006eafe c2300790 c2300780 00000001 c236aefc 
[  751.569398]        c2348930 c2348928 c2217560 00000001 00000af9 cec7134c 000000ae c2330550 
[  751.578417] Call Trace:
[  751.581199]  [<c012bd90>] worker_thread+0x207/0x225
[  751.586336]  [<c012fe68>] kthread+0xb7/0xbc
[  751.590761]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.596166] events/2      S 00000004     0    12      1            13    11 (L-TLB)
[  751.604385] c2359f34 c2359f24 00000004 00000004 00000202 00000001 c2354540 000007d0 
[  751.612506]        c2359ef4 c012bb5c c22211b8 0006eb01 00000000 c2300780 c22211a4 c2359efc 
[  751.621526]        c23488b0 c23488a8 c221f560 00000002 00000801 cef4a869 000000ae c2330030 
[  751.630546] Call Trace:
[  751.633328]  [<c012bd90>] worker_thread+0x207/0x225
[  751.638465]  [<c012fe68>] kthread+0xb7/0xbc
[  751.642889]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.648295] events/3      S 00000003     0    13      1            14    12 (L-TLB)
[  751.656514] c236cf34 c236cf24 00000004 00000003 00000202 00000001 c2354540 000007d0 
[  751.664638]        c236cef4 c012bb5c c22291b8 0006eb02 00000000 c2300780 c22291a4 c236cefc 
[  751.673658]        c2348830 c2348828 c2227560 00000003 00000529 cf03c93c 000000ae c2337a70 
[  751.682681] Call Trace:
[  751.685462]  [<c012bd90>] worker_thread+0x207/0x225
[  751.690602]  [<c012fe68>] kthread+0xb7/0xbc
[  751.695027]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.700432] khelper       S 00000004     0    14      1            15    13 (L-TLB)
[  751.708654] c235af34 c235af24 00000004 00000004 00000000 c235aef4 c0117b5d f7ba3c70 
[  751.716776]        00000003 00000000 00000000 f7ba3d00 f7ba3cf4 f7ba3cf8 00000202 c235af1c 
[  751.725796]        c23487b0 c23487a8 c221f560 00000002 000001db da3e6193 00000056 c2330030 
[  751.734818] Call Trace:
[  751.737599]  [<c012bd90>] worker_thread+0x207/0x225
[  751.742737]  [<c012fe68>] kthread+0xb7/0xbc
[  751.747160]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.752565] kthread       S 00000001     0    15      1    20     144    14 (L-TLB)
[  751.760786] c2389f34 c2389f24 00000004 00000001 c2389ef0 c0117b5d f78ebd80 00000003 
[  751.768908]        00000000 00000000 f78ebe20 f78ebe14 f78ebe18 00000202 c2389f18 c0117cbb 
[  751.777928]        c2380b30 c2380b28 c2217560 00000001 00000187 fa724d73 00000066 c2330550 
[  751.786947] Call Trace:
[  751.789730]  [<c012bd90>] worker_thread+0x207/0x225
[  751.794868]  [<c012fe68>] kthread+0xb7/0xbc
[  751.799292]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.804697] kblockd/0     S 00000002     0    20     15            21       (L-TLB)
[  751.813752] c238bf34 c238bf20 00000004 00000002 c238bed0 c040906a c238bef8 00000000 
[  751.821916]        c0579414 f7f7aedc c238bee8 00000000 f7a95a70 f7f734f4 c23eef80 f7a95a70 
[  751.830997]        00000000 c220fec0 c220f560 00000000 000017d6 aee7a4ca 000000a9 f7a95a70 
[  751.840077] Call Trace:
[  751.842877]  [<c012bd90>] worker_thread+0x207/0x225
[  751.848051]  [<c012fe68>] kthread+0xb7/0xbc
[  751.852506]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.857949] kblockd/1     S 00000001     0    21     15            22    20 (L-TLB)
[  751.866271] f7d58f34 f7d58f24 00000004 00000001 f7d58ed0 c040906a f7d58ef8 c02fccc2 
[  751.874450]        c0579414 f7f7ac5c f7d58ee8 00000000 c23eef00 f7f734f4 c23eef00 f7f7359c 
[  751.883480]        c23eef30 c23eef28 c2217560 00000001 00000c15 9a287d8b 00000091 c2330550 
[  751.892508] Call Trace:
[  751.895292]  [<c012bd90>] worker_thread+0x207/0x225
[  751.900436]  [<c012fe68>] kthread+0xb7/0xbc
[  751.904863]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.910273] kblockd/2     S 00000004     0    22     15            23    21 (L-TLB)
[  751.918595] c238ff34 c238ff24 00000004 00000004 c238fed0 c040906a c238fef8 c02fccc2 
[  751.926724]        c0579414 d6cb69dc 00000080 00000000 c23eee80 f7f734f4 c23eee80 f7f7359c 
[  751.935754]        c23eeeb0 c23eeea8 c221f560 00000002 000011d4 afbc9d2d 000000a9 c2330030 
[  751.944784] Call Trace:
[  751.947568]  [<c012bd90>] worker_thread+0x207/0x225
[  751.952711]  [<c012fe68>] kthread+0xb7/0xbc
[  751.957139]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  751.962550] kblockd/3     S 00000003     0    23     15            24    22 (L-TLB)
[  751.970871] f7d59f34 f7d59f24 00000004 00000003 f7f7a2fc 000b884f 00000000 00000202 
[  751.979001]        00000001 f7f7a2fc f7d59ee8 c040906a f7d59f10 c02fccc2 c0579414 f7f7a2fc 
[  751.988039]        c23eee30 c23eee28 c2227560 00000003 00000d8c 29f94785 0000003a c2337a70 
[  751.997120] Call Trace:
[  751.999921]  [<c012bd90>] worker_thread+0x207/0x225
[  752.005093]  [<c012fe68>] kthread+0xb7/0xbc
[  752.009548]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.014990] kacpid        S 00000002     0    24     15           142    23 (L-TLB)
[  752.023312] f7d78f34 f7d78f24 00000004 00000002 00000000 00000001 00000100 00000000 
[  752.031490]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  752.040571]        00000000 00000202 c220f560 00000000 00000189 027f7e52 00000000 c048db40 
[  752.049651] Call Trace:
[  752.052452]  [<c012bd90>] worker_thread+0x207/0x225
[  752.057624]  [<c012fe68>] kthread+0xb7/0xbc
[  752.062078]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.067491] pdflush       S 00000002     0   142     15           143    24 (L-TLB)
[  752.075814] f7d5df68 f7d5df58 00000004 00000002 c0124c50 c0493a5c 0006f49d f7d5df68 
[  752.083979]        c014153c c0493a5c 0006f49d 00066be5 00000000 00000000 f7d5df18 00000400 
[  752.093099]        00000000 00000000 c220f560 00000000 000001d3 aecc404f 000000ae c048db40 
[  752.102231] Call Trace:
[  752.105048]  [<c0141df8>] __pdflush+0x84/0x199
[  752.109800]  [<c0141f4d>] pdflush+0x40/0x47
[  752.114279]  [<c012fe68>] kthread+0xb7/0xbc
[  752.118759]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.124233] pdflush       D 00000001     0   143     15           145   142 (L-TLB)
[  752.132554] f7d8aa48 f7d8aa38 00000004 00000001 f7d8aa34 00000202 f7d8a9f8 c01302cf 
[  752.140776]        f7b26080 c2330550 f7d8aa28 f7d8aa54 00000202 c2217fe0 f7d8aa5c 00000202 
[  752.149907]        c2217fe0 f7d8aa5c c2217560 00000001 000000ed dd6ce28f 000000ae c2330550 
[  752.159038] Call Trace:
[  752.161855]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  752.167148]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  752.172712]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  752.178280]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  752.183936]  [<c014714d>] shrink_zone+0xe0/0xfa
[  752.188777]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  752.193746]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  752.199157]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  752.204300]  [<c0142d35>] kmem_getpages+0x34/0x9d
[  752.209264]  [<c0143b91>] cache_grow+0xaf/0x16c
[  752.214050]  [<c0143db2>] cache_alloc_refill+0x164/0x207
[  752.219639]  [<c014403b>] kmem_cache_alloc+0x4e/0x50
[  752.224871]  [<c01c4e05>] nfs_create_request+0x3d/0xcc
[  752.230283]  [<c01c9151>] nfs_update_request+0x172/0x1d9
[  752.235874]  [<c01c867e>] nfs_writepage_async+0x36/0x7e
[  752.241376]  [<c01c888f>] nfs_writepage+0x1a8/0x1dc
[  752.246518]  [<c017dd9b>] mpage_writepages+0x232/0x399
[  752.251930]  [<c01c88f1>] nfs_writepages+0x2e/0x11e
[  752.257073]  [<c01416f2>] do_writepages+0x2e/0x53
[  752.262067]  [<c017c072>] __sync_single_inode+0x60/0x1f1
[  752.267689]  [<c017c295>] __writeback_single_inode+0x92/0x195
[  752.273761]  [<c017c555>] sync_sb_inodes+0x1bd/0x2c2
[  752.279025]  [<c017c734>] writeback_inodes+0xda/0xe6
[  752.284287]  [<c01413e8>] background_writeout+0x69/0xa2
[  752.289819]  [<c0141e35>] __pdflush+0xc1/0x199
[  752.294545]  [<c0141f4d>] pdflush+0x40/0x47
[  752.298998]  [<c012fe68>] kthread+0xb7/0xbc
[  752.303452]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.308895] kswapd0       D 00000003     0   144      1           804    15 (L-TLB)
[  752.317218] f7dd8e14 f7dd8e04 00000004 00000003 f7dd8dac 00000004 00000001 c21ebd68 
[  752.325395]        c21ebd8c c2337a70 c21ebdd4 c21ebc00 00000202 c2227fe0 f7dd8e28 00000202 
[  752.334477]        c2227fe0 f7dd8e28 c2227560 00000003 0000013a d9cae466 000000ae c2337a70 
[  752.343561] Call Trace:
[  752.346348]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  752.351581]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  752.357081]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  752.362581]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  752.368171]  [<c014714d>] shrink_zone+0xe0/0xfa
[  752.372956]  [<c0147611>] balance_pgdat+0x286/0x37e
[  752.378102]  [<c01477ee>] kswapd+0xe5/0x10f
[  752.382530]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.387941] aio/0         S 00000002     0   145     15           146   143 (L-TLB)
[  752.396263] f7e34f34 f7e34f20 00000004 00000002 00000000 00000001 00000100 00000000 
[  752.404393]        00000080 00000080 00000080 c05566ac f7dd7550 c05566a0 c2217ec0 f7dd7550 
[  752.413421]        00000000 c220fec0 c220f560 00000000 0000013f 2ca67fde 00000000 f7dd7550 
[  752.422449] Call Trace:
[  752.425233]  [<c012bd90>] worker_thread+0x207/0x225
[  752.430375]  [<c012fe68>] kthread+0xb7/0xbc
[  752.434802]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.440212] aio/1         S 00000000     0   146     15           147   145 (L-TLB)
[  752.448533] f7e1df34 c2361030 c22175a8 00000000 00000000 00000001 00000100 00000000 
[  752.456662]        00000080 00000000 2ca50f66 00000000 c2361030 00000000 c220fec0 c2361030 
[  752.465692]        00000000 c2217ec0 c2217560 00000001 0000016c 2ca6bdf9 00000000 c2361030 
[  752.474725] Call Trace:
[  752.477525]  [<c012bd90>] worker_thread+0x207/0x225
[  752.482699]  [<c012fe68>] kthread+0xb7/0xbc
[  752.487154]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.492596] aio/2         S 00000004     0   147     15           148   146 (L-TLB)
[  752.500917] f7e35f34 f7e35f24 00000004 00000004 00000000 00000001 00000100 00000000 
[  752.509093]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  752.518173]        00000000 00000202 c221f560 00000002 000001a5 2ca71c86 00000000 c2330030 
[  752.527257] Call Trace:
[  752.530057]  [<c012bd90>] worker_thread+0x207/0x225
[  752.535230]  [<c012fe68>] kthread+0xb7/0xbc
[  752.539685]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.545128] aio/3         S 00000003     0   148     15           149   147 (L-TLB)
[  752.553449] f7e1ef34 f7e1ef24 00000004 00000003 00000000 00000001 00000100 00000080 
[  752.561668]        00000080 00000000 00000000 c05566a0 c05566a0 00000000 c220fec0 c220fec0 
[  752.570747]        00000000 00000202 c2227560 00000003 00000191 2ca776c8 00000000 c2337a70 
[  752.579829] Call Trace:
[  752.582629]  [<c012bd90>] worker_thread+0x207/0x225
[  752.587803]  [<c012fe68>] kthread+0xb7/0xbc
[  752.592258]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.597733] xfslogd/0     S 00000000     0   149     15           150   148 (L-TLB)
[  752.606054] f7e37f34 c2361030 c220f5a8 00000000 00000000 00000001 00000100 00000000 
[  752.614275]        00000100 00000080 2e49f705 00000000 c2361030 c05566a0 c2217ec0 c2361030 
[  752.623405]        00000000 c220fec0 c220f560 00000000 0000016d 2e4aa29a 00000000 c2361030 
[  752.633358] Call Trace:
[  752.636175]  [<c012bd90>] worker_thread+0x207/0x225
[  752.641378]  [<c012fe68>] kthread+0xb7/0xbc
[  752.645857]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.651331] xfslogd/1     S 00000001     0   150     15           151   149 (L-TLB)
[  752.659652] f7e75f34 f7e75f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  752.667875]        00000100 00000080 00000080 c05566a0 f7e36550 c05566ac c220fec0 f7e36550 
[  752.677006]        00000000 c2217ec0 c2217560 00000001 000000f4 2e4b28d6 00000000 f7e36550 
[  752.686136] Call Trace:
[  752.688953]  [<c012bd90>] worker_thread+0x207/0x225
[  752.694155]  [<c012fe68>] kthread+0xb7/0xbc
[  752.698634]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.704107] xfslogd/2     S 00000004     0   151     15           152   150 (L-TLB)
[  752.712427] f7e38f34 f7e38f24 00000004 00000004 00000000 00000001 00000100 00000080 
[  752.720649]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  752.729781]        00000000 00000202 c221f560 00000002 0000015d 2e4b69d2 00000000 c2330030 
[  752.738911] Call Trace:
[  752.741727]  [<c012bd90>] worker_thread+0x207/0x225
[  752.746928]  [<c012fe68>] kthread+0xb7/0xbc
[  752.751408]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.756882] xfslogd/3     S 00000003     0   152     15           153   151 (L-TLB)
[  752.765203] f7e76f34 f7e76f24 00000004 00000003 00000000 00000001 00000100 00000080 
[  752.773426]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  752.782557]        00000000 00000202 c2227560 00000003 00000173 2e4bc489 00000000 c2337a70 
[  752.791687] Call Trace:
[  752.794503]  [<c012bd90>] worker_thread+0x207/0x225
[  752.799706]  [<c012fe68>] kthread+0xb7/0xbc
[  752.804185]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.809659] xfsdatad/0    S 00000000     0   153     15           154   152 (L-TLB)
[  752.817979] f7e3af34 c2361030 c220f5a8 00000000 00000000 00000001 00000100 00000000 
[  752.826200]        00000100 00000080 2e4b784f 00000000 c2361030 c05566a0 c2217ec0 c2361030 
[  752.835272]        00000000 c220fec0 c220f560 00000000 00000131 2e4c227a 00000000 c2361030 
[  752.844354] Call Trace:
[  752.847155]  [<c012bd90>] worker_thread+0x207/0x225
[  752.852329]  [<c012fe68>] kthread+0xb7/0xbc
[  752.856783]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.862226] xfsdatad/1    S 00000001     0   154     15           155   153 (L-TLB)
[  752.870547] f7e78f34 f7e78f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  752.878723]        00000100 00000080 00000080 c05566a0 f7e3ba70 c05566ac c220fec0 f7e3ba70 
[  752.887803]        00000000 c2217ec0 c2217560 00000001 000000f6 2e4c9b2f 00000000 f7e3ba70 
[  752.896885] Call Trace:
[  752.899686]  [<c012bd90>] worker_thread+0x207/0x225
[  752.904859]  [<c012fe68>] kthread+0xb7/0xbc
[  752.909313]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.914755] xfsdatad/2    S 00000004     0   155     15           156   154 (L-TLB)
[  752.923077] f7e3cf34 f7e3cf24 00000004 00000004 00000000 00000001 00000100 00000080 
[  752.931254]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  752.940335]        00000000 00000202 c221f560 00000002 00000136 2e4cd917 00000000 c2330030 
[  752.949449] Call Trace:
[  752.952265]  [<c012bd90>] worker_thread+0x207/0x225
[  752.957468]  [<c012fe68>] kthread+0xb7/0xbc
[  752.961947]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  752.967421] xfsdatad/3    S 00000003     0   156     15           157   155 (L-TLB)
[  752.975743] f7e7af34 f7e7af24 00000004 00000003 00000000 00000001 00000100 00000080 
[  752.983965]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  752.993096]        00000000 00000202 c2227560 00000003 0000013e 2e4d313a 00000000 c2337a70 
[  753.002227] Call Trace:
[  753.005043]  [<c012bd90>] worker_thread+0x207/0x225
[  753.010247]  [<c012fe68>] kthread+0xb7/0xbc
[  753.014726]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.020200] xfsbufd       S 00000004     0   157     15           742   156 (L-TLB)
[  753.028521] f7e3df44 f7e3df34 00000004 00000004 00000100 00000080 00000080 00000000 
[  753.036743]        c2337a70 c2330030 af846c0b 000000a9 00000202 c221ffe0 f7e3df58 00000202 
[  753.045874]        c221ffe0 f7e3df58 c221f560 00000002 00000096 abf07eb3 000000ae c2330030 
[  753.055005] Call Trace:
[  753.057822]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  753.063115]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  753.069673]  [<c0272754>] xfsbufd+0x4e/0x1b0
[  753.074245]  [<c012fe68>] kthread+0xb7/0xbc
[  753.078723]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.084196] kseriod       S 00000002     0   742     15          1514   157 (L-TLB)
[  753.092517] f7f16f5c f7f16f4c 00000004 00000002 c02eff05 c04b8f24 f7f16f10 c02efe91 
[  753.100730]        c04b8f08 c04a8738 c04b8f24 c04a63e0 f7f16f34 c02ef54e c04b8f08 c04a8738 
[  753.109812]        00000282 00000202 c220f560 00000000 000a8380 b437cbfc 00000000 c048db40 
[  753.118894] Call Trace:
[  753.121695]  [<c02e4762>] serio_thread+0xea/0xec
[  753.126600]  [<c012fe68>] kthread+0xb7/0xbc
[  753.131055]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.136498] kjournald     S 00000002     0   804      1          1519   144 (L-TLB)
[  753.144821] f7eaff58 f7eaff48 00000004 00000002 f726204c 00000000 00000000 f7fc6800 
[  753.152997]        00000000 f7171400 f7afcfa8 000003d0 00000202 c2217fe0 f7eaffb8 f7eaff2c 
[  753.162079]        f7fb086c f7fb0864 c220f560 00000000 000004a8 8a6284da 000000a6 c048db40 
[  753.171159] Call Trace:
[  753.173961]  [<c01b0eef>] kjournald+0x1d6/0x223
[  753.178777]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.184220] rpciod/0      D 00000002     0  1514     15          1515   742 (L-TLB)
[  753.192540] f7b96aa8 f7b96a98 00000004 00000002 f7ff8f18 00000001 00000003 00000b9d 
[  753.200669]        324272cc c048db40 02000000 f7e4f46c 00000202 c220ffe0 f7b96abc 00000202 
[  753.209698]        c220ffe0 f7b96abc c220f560 00000000 0000012d dd6cd092 000000ae c048db40 
[  753.218726] Call Trace:
[  753.221510]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  753.226743]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  753.232242]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  753.237743]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  753.243332]  [<c014714d>] shrink_zone+0xe0/0xfa
[  753.248116]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  753.253080]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  753.258492]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  753.263635]  [<c03b74ad>] tcp_sendmsg+0xaa0/0xb78
[  753.268602]  [<c03d4666>] inet_sendmsg+0x48/0x53
[  753.273476]  [<c0388716>] sock_sendmsg+0xb8/0xd3
[  753.278353]  [<c0388773>] kernel_sendmsg+0x42/0x4f
[  753.283406]  [<c038bc00>] sock_no_sendpage+0x5e/0x77
[  753.288638]  [<c03ee7af>] xs_tcp_send_request+0x2af/0x375
[  753.294320]  [<c03ed4c5>] xprt_transmit+0x4f/0x20b
[  753.299374]  [<c03ebce1>] call_transmit+0x68/0xc8
[  753.304340]  [<c03f0962>] __rpc_execute+0x5c/0x1ea
[  753.309423]  [<c03f0b27>] rpc_async_schedule+0x11/0x15
[  753.314844]  [<c012bd1d>] worker_thread+0x194/0x225
[  753.319987]  [<c012fe68>] kthread+0xb7/0xbc
[  753.324415]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.329826] rpciod/1      S 00000001     0  1515     15          1516  1514 (L-TLB)
[  753.338147] f78dbf34 f78dbf20 00000004 00000001 00000000 c03ed2f0 f7b13fc0 00000000 
[  753.346277]        f7b13e00 c3a2e504 c3a2e504 00000000 f7d89a70 c03ebce1 c3a2e504 f7d89a70 
[  753.355308]        00000000 c2217ec0 c2217560 00000001 00002aff 0db3409e 000000aa f7d89a70 
[  753.364338] Call Trace:
[  753.367122]  [<c012bd90>] worker_thread+0x207/0x225
[  753.372265]  [<c012fe68>] kthread+0xb7/0xbc
[  753.376695]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.382106] rpciod/2      S 00000004     0  1516     15          1517  1515 (L-TLB)
[  753.390429] f7ba6f34 f7ba6f24 00000004 00000004 00000000 00000000 00000003 00000000 
[  753.398570]        c4866584 00000000 f7ba6eec c0296593 00000000 f7ba6f00 c04071af f7b13e00 
[  753.407652]        f71717b0 f71717a8 c221f560 00000002 000021eb af7442db 000000a9 c2330030 
[  753.416734] Call Trace:
[  753.419535]  [<c012bd90>] worker_thread+0x207/0x225
[  753.424709]  [<c012fe68>] kthread+0xb7/0xbc
[  753.429970]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.435413] rpciod/3      S 00000003     0  1517     15                1516 (L-TLB)
[  753.443733] f7154f34 f7154f20 00000004 00000003 00000000 00000000 00000003 00000000 
[  753.451909]        c2330030 00000000 f7154eec c0296593 f717b030 00000040 c04071af f717b030 
[  753.460991]        00000000 c2227ec0 c2227560 00000003 00003481 af9995ef 000000a9 f717b030 
[  753.470072] Call Trace:
[  753.472873]  [<c012bd90>] worker_thread+0x207/0x225
[  753.478046]  [<c012fe68>] kthread+0xb7/0xbc
[  753.482501]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.487976] portmap       S 00000002     0  1519      1          1541   804 (NOTLB)
[  753.496297] f717cf00 f717ceec 00000004 00000002 00000202 f7b8100c 00000202 00000000 
[  753.504473]        c2330550 f7b81000 f7e87080 00000202 f7e79030 00000003 f717ced0 f7e79030 
[  753.513568]        00000000 c220fec0 c220f560 00000000 0000c0e9 607461be 00000089 f7e79030 
[  753.522700] Call Trace:
[  753.525517]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  753.530808]  [<c016ce88>] do_poll+0x9a/0xb9
[  753.535289]  [<c016cffd>] sys_poll+0x156/0x221
[  753.540039]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  753.545422] kjournald     S 00000002     0  1541      1          1544  1519 (L-TLB)
[  753.553744] f71d3f58 f71d3f48 00000004 00000002 f724d02c 00000000 00000000 f71d1800 
[  753.561965]        00000000 f7171e00 f7afcd6c 0000020c 00000202 c220ffe0 f71d3fb8 f71d3f2c 
[  753.571070]        f7fb066c f7fb0664 c220f560 00000000 00000585 2cebc346 000000a7 c048db40 
[  753.580151] Call Trace:
[  753.582953]  [<c01b0eef>] kjournald+0x1d6/0x223
[  753.587766]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  753.593210] writetest     D 00000003     0  1544      1                1541 (NOTLB)
[  753.601532] f7adce10 f7adce00 00000004 00000003 f7adcdd4 f7ecfd80 f7adcde8 c01c7bcf 
[  753.609709]        f71b25c0 00000008 c01c7a21 f7adcdcc 00000082 f7b13600 f7adcdd4 f71b25c0 
[  753.618790]        f7adcdd4 f7adcdd4 c2227560 00000003 00000630 c562b75c 000000a9 c2337a70 
[  753.627872] Call Trace:
[  753.630672]  [<c040863b>] io_schedule+0x26/0x30
[  753.635488]  [<c013ab27>] sync_page+0x39/0x4e
[  753.640123]  [<c0408929>] __wait_on_bit_lock+0x58/0x67
[  753.645561]  [<c013b343>] __lock_page+0x84/0x8c
[  753.650402]  [<c013c3c9>] filemap_nopage+0x1e4/0x347
[  753.655695]  [<c014b4b4>] do_no_page+0x70/0x25b
[  753.660536]  [<c014b812>] __handle_mm_fault+0xef/0x22a
[  753.666011]  [<c0409a84>] do_page_fault+0x179/0x5e6
[  753.671214]  [<c01039cf>] error_code+0x4f/0x54

[  807.227512] SysRq : Show State
[  807.230773] 
[  807.230774]                                                sibling
[  807.238834]   task             PC      pid father child younger older
[  807.245576] bash          S 00000001     0     1      0     2               (NOTLB)
[  807.253896] c2331f08 c2331ef8 00000004 00000001 00000044 c21fd780 c04938a8 000200d2 
[  807.262113]        c2330a70 c2331eec c013f968 000200d2 00000000 c04938a8 00000044 0000000e 
[  807.271238]        c21fd780 00000010 c2217560 00000001 0000391a 0183f473 000000a6 c2330550 
[  807.280363] Call Trace:
[  807.283179]  [<c011fa57>] do_wait+0x18a/0x376
[  807.287838]  [<c011fd03>] sys_wait4+0x3e/0x42
[  807.292495]  [<c011fd2e>] sys_waitpid+0x27/0x2b
[  807.297333]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  807.302714] migration/0   S 00000002     0     2      1             3       (L-TLB)
[  807.311031] c2339f94 c2339f84 00000004 00000002 c0116b9c c2337a70 c22275a8 00000001 
[  807.319190]        c220f5ac 00000001 00000073 c220f958 c220f958 c22275a8 c220f5a8 00000000 
[  807.328211]        c2227560 00000003 c220f560 00000000 000017c2 aa8db191 000000a9 c048db40 
[  807.337230] Call Trace:
[  807.340011]  [<c0118d0c>] migration_thread+0x81/0x10d
[  807.345330]  [<c012fe68>] kthread+0xb7/0xbc
[  807.349757]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.355163] ksoftirqd/0   S 00000000     0     3      1             4     2 (L-TLB)
[  807.363383] c233af98 c2337030 c220f560 00000000 000004db 000e078d 00000000 c233ba70 
[  807.371505]        c2337030 c233715c 00000001 c2331f5c c2330a70 ffffffff c2337030 c233af6c 
[  807.380526]        00000000 00000000 c220f560 00000000 000002b2 000ea053 00000000 c2330a70 
[  807.389545] Call Trace:
[  807.392327]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  807.396929]  [<c012fe68>] kthread+0xb7/0xbc
[  807.401353]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.406758] migration/1   S 00000001     0     4      1             5     3 (L-TLB)
[  807.414979] c233cf94 c233cf80 00000004 00000001 00000082 00000001 c233cf44 00000000 
[  807.423103]        c048db40 c2337a70 00000003 c2227560 c2330a70 00000009 00000008 c2330a70 
[  807.432126]        00000000 c2217ec0 c2217560 00000001 00000eaf 3827d003 000000a1 c2330a70 
[  807.441147] Call Trace:
[  807.443931]  [<c0118d0c>] migration_thread+0x81/0x10d
[  807.449250]  [<c012fe68>] kthread+0xb7/0xbc
[  807.453675]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.459083] ksoftirqd/1   S 00000001     0     5      1             6     4 (L-TLB)
[  807.467305] c2345f98 c2345f88 00000004 00000001 000000c7 00180089 00000000 c233b550 
[  807.475432]        c233b550 c2330a70 00000001 c2331f28 c2345000 ffffffff c233b550 c2345f6c 
[  807.484477]        c0407ed4 c22175a8 c2217560 00000001 00000177 2fc9a4b5 00000000 c2330550 
[  807.493558] Call Trace:
[  807.496359]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  807.500994]  [<c012fe68>] kthread+0xb7/0xbc
[  807.505448]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.510890] migration/2   S 00000004     0     6      1             7     5 (L-TLB)
[  807.519212] c2346f94 c2346f80 00000004 00000004 00000082 c2330550 c22175a8 00000000 
[  807.527390]        c2337a70 c2330550 00000001 c2217560 f7e79030 00000002 00000002 f7e79030 
[  807.536470]        00000000 c221fec0 c221f560 00000002 00000c37 37d42ab3 00000058 f7e79030 
[  807.545552] Call Trace:
[  807.548352]  [<c0118d0c>] migration_thread+0x81/0x10d
[  807.553706]  [<c012fe68>] kthread+0xb7/0xbc
[  807.558161]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.563602] ksoftirqd/2   S 00000002     0     7      1             8     6 (L-TLB)
[  807.571923] c234df98 c234ca70 c221f560 00000002 00000163 00275526 00000000 c234ca70 
[  807.580100]        c234ca70 c234cb9c 00000001 c2331f28 c234d000 ffffffff c234ca70 c234df6c 
[  807.589183]        c0407ed4 c221f5a8 c221f560 00000002 00000043 00275786 00000000 c2330030 
[  807.598264] Call Trace:
[  807.601065]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  807.605700]  [<c012fe68>] kthread+0xb7/0xbc
[  807.610155]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.615598] migration/3   S 00000003     0     8      1             9     7 (L-TLB)
[  807.623918] c234ef94 c234ef80 00000004 00000003 00000082 00000001 c234ef44 00000000 
[  807.632095]        c2330030 c2330550 00000001 c2217560 f70f8030 00000011 00000002 f70f8030 
[  807.641174]        00000000 c2227ec0 c2227560 00000003 0000105f 353ed25e 00000058 f70f8030 
[  807.650256] Call Trace:
[  807.653057]  [<c0118d0c>] migration_thread+0x81/0x10d
[  807.658410]  [<c012fe68>] kthread+0xb7/0xbc
[  807.662866]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.668308] ksoftirqd/3   S 00000003     0     9      1            10     8 (L-TLB)
[  807.676629] c2353f98 c2353f88 00000004 00000003 000000c9 00367434 00000000 c234c030 
[  807.684806]        c234c030 c2361550 00000001 c2331f28 c2353000 ffffffff c234c030 c2353f6c 
[  807.693887]        c0407ed4 c22275a8 c2227560 00000003 00000182 364e7604 00000058 c2337a70 
[  807.702968] Call Trace:
[  807.705768]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  807.710402]  [<c012fe68>] kthread+0xb7/0xbc
[  807.714856]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.720299] events/0      R running     0    10      1            11     9 (L-TLB)
[  807.728530] events/1      S 00000001     0    11      1            12    10 (L-TLB)
[  807.736850] c236af34 c236af24 00000004 00000001 00000202 00000001 c2354540 000007d0 
[  807.745072]        c236aef4 c012bb5c c22191b8 0007bdee c2300290 c2300780 00000004 c236aefc 
[  807.755044]        c2348930 c2348928 c2217560 00000001 00000918 bf47472a 000000bb c2330550 
[  807.764175] Call Trace:
[  807.766991]  [<c012bd90>] worker_thread+0x207/0x225
[  807.772194]  [<c012fe68>] kthread+0xb7/0xbc
[  807.776673]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.782116] events/2      S 00000004     0    12      1            13    11 (L-TLB)
[  807.790437] c2359f34 c2359f24 00000004 00000004 00000202 00000001 c2354540 000007d0 
[  807.798612]        c2359ef4 c012bb5c c22211b8 0007bdf1 f7e6f1d0 c2300780 00000002 c2359efc 
[  807.807692]        c23488b0 c23488a8 c221f560 00000002 00000805 bf74eeb2 000000bb c2330030 
[  807.816810] Call Trace:
[  807.819624]  [<c012bd90>] worker_thread+0x207/0x225
[  807.824824]  [<c012fe68>] kthread+0xb7/0xbc
[  807.829302]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.834772] events/3      S 00000003     0    13      1            14    12 (L-TLB)
[  807.843088] c236cf34 c236cf24 00000004 00000003 00000202 00000001 c2354540 000007d0 
[  807.851306]        c236cef4 c012bb5c c22291b8 0007bdf2 00000000 c2300780 c22291a4 c236cefc 
[  807.860430]        c2348830 c2348828 c2227560 00000003 00000521 bf840f13 000000bb c2337a70 
[  807.869556] Call Trace:
[  807.872371]  [<c012bd90>] worker_thread+0x207/0x225
[  807.877571]  [<c012fe68>] kthread+0xb7/0xbc
[  807.882047]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.887517] khelper       S 00000004     0    14      1            15    13 (L-TLB)
[  807.895835] c235af34 c235af24 00000004 00000004 00000000 c235aef4 c0117b5d f7ba3c70 
[  807.904053]        00000003 00000000 00000000 f7ba3d00 f7ba3cf4 f7ba3cf8 00000202 c235af1c 
[  807.913140]        c23487b0 c23487a8 c221f560 00000002 000001db da3e6193 00000056 c2330030 
[  807.922272] Call Trace:
[  807.925088]  [<c012bd90>] worker_thread+0x207/0x225
[  807.930291]  [<c012fe68>] kthread+0xb7/0xbc
[  807.934771]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.940245] kthread       S 00000001     0    15      1    20     144    14 (L-TLB)
[  807.948567] c2389f34 c2389f24 00000004 00000001 c2389ef0 c0117b5d f78ebd80 00000003 
[  807.956789]        00000000 00000000 f78ebe20 f78ebe14 f78ebe18 00000202 c2389f18 c0117cbb 
[  807.965920]        c2380b30 c2380b28 c2217560 00000001 00000187 fa724d73 00000066 c2330550 
[  807.975051] Call Trace:
[  807.977867]  [<c012bd90>] worker_thread+0x207/0x225
[  807.983070]  [<c012fe68>] kthread+0xb7/0xbc
[  807.987549]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  807.993022] kblockd/0     S 00000002     0    20     15            21       (L-TLB)
[  808.001343] c238bf34 c238bf20 00000004 00000002 c238bed0 c040906a c238bef8 00000000 
[  808.009566]        c0579414 f7f7aedc c238bee8 00000000 f7a95a70 f7f734f4 c23eef80 f7a95a70 
[  808.018595]        00000000 c220fec0 c220f560 00000000 000017d6 aee7a4ca 000000a9 f7a95a70 
[  808.027623] Call Trace:
[  808.030408]  [<c012bd90>] worker_thread+0x207/0x225
[  808.035551]  [<c012fe68>] kthread+0xb7/0xbc
[  808.039980]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.045389] kblockd/1     S 00000001     0    21     15            22    20 (L-TLB)
[  808.053710] f7d58f34 f7d58f24 00000004 00000001 f7d58ed0 c040906a f7d58ef8 c02fccc2 
[  808.061840]        c0579414 f7f7ac5c f7d58ee8 00000000 c23eef00 f7f734f4 c23eef00 f7f7359c 
[  808.070869]        c23eef30 c23eef28 c2217560 00000001 00000c15 9a287d8b 00000091 c2330550 
[  808.079898] Call Trace:
[  808.082683]  [<c012bd90>] worker_thread+0x207/0x225
[  808.087825]  [<c012fe68>] kthread+0xb7/0xbc
[  808.092253]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.097664] kblockd/2     S 00000004     0    22     15            23    21 (L-TLB)
[  808.105985] c238ff34 c238ff24 00000004 00000004 c238fed0 c040906a c238fef8 c02fccc2 
[  808.114151]        c0579414 d6cb69dc 00000080 00000000 c23eee80 f7f734f4 c23eee80 f7f7359c 
[  808.123182]        c23eeeb0 c23eeea8 c221f560 00000002 000011d4 afbc9d2d 000000a9 c2330030 
[  808.132211] Call Trace:
[  808.134995]  [<c012bd90>] worker_thread+0x207/0x225
[  808.140138]  [<c012fe68>] kthread+0xb7/0xbc
[  808.144567]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.149977] kblockd/3     S 00000003     0    23     15            24    22 (L-TLB)
[  808.158298] f7d59f34 f7d59f24 00000004 00000003 f7f7a2fc 000b884f 00000000 00000202 
[  808.166427]        00000001 f7f7a2fc f7d59ee8 c040906a f7d59f10 c02fccc2 c0579414 f7f7a2fc 
[  808.175456]        c23eee30 c23eee28 c2227560 00000003 00000d8c 29f94785 0000003a c2337a70 
[  808.184484] Call Trace:
[  808.187267]  [<c012bd90>] worker_thread+0x207/0x225
[  808.192409]  [<c012fe68>] kthread+0xb7/0xbc
[  808.196837]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.202313] kacpid        S 00000002     0    24     15           142    23 (L-TLB)
[  808.210635] f7d78f34 f7d78f24 00000004 00000002 00000000 00000001 00000100 00000000 
[  808.218858]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  808.227991]        00000000 00000202 c220f560 00000000 00000189 027f7e52 00000000 c048db40 
[  808.237125] Call Trace:
[  808.239942]  [<c012bd90>] worker_thread+0x207/0x225
[  808.245144]  [<c012fe68>] kthread+0xb7/0xbc
[  808.249624]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.255097] pdflush       S 00000002     0   142     15           143    24 (L-TLB)
[  808.263418] f7d5df68 f7d5df58 00000004 00000002 c0124c50 c0493a5c 0007cb75 f7d5df68 
[  808.271640]        c014153c c0493a5c 0007cb75 000742bd 00000000 00000000 f7d5df18 00000400 
[  808.280772]        00000000 00000000 c220f560 00000000 000001c7 dad93105 000000bb c048db40 
[  808.289903] Call Trace:
[  808.292719]  [<c0141df8>] __pdflush+0x84/0x199
[  808.297471]  [<c0141f4d>] pdflush+0x40/0x47
[  808.301950]  [<c012fe68>] kthread+0xb7/0xbc
[  808.306430]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.311904] pdflush       D 00000001     0   143     15           145   142 (L-TLB)
[  808.320226] f7d8aa48 f7d8aa38 00000004 00000001 f7d8aa34 00000202 f7d8a9f8 c01302cf 
[  808.328447]        f7b26080 c2330550 f7d8aa28 f7d8aa54 00000202 c2217fe0 f7d8aa5c 00000202 
[  808.337578]        c2217fe0 f7d8aa5c c2217560 00000001 00000115 ed121eb1 000000bb c2330550 
[  808.346710] Call Trace:
[  808.349526]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  808.354818]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  808.360383]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  808.365948]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  808.371603]  [<c014714d>] shrink_zone+0xe0/0xfa
[  808.376444]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  808.381465]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  808.386939]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  808.392142]  [<c0142d35>] kmem_getpages+0x34/0x9d
[  808.397166]  [<c0143b91>] cache_grow+0xaf/0x16c
[  808.402007]  [<c0143db2>] cache_alloc_refill+0x164/0x207
[  808.407662]  [<c014403b>] kmem_cache_alloc+0x4e/0x50
[  808.412955]  [<c01c4e05>] nfs_create_request+0x3d/0xcc
[  808.418430]  [<c01c9151>] nfs_update_request+0x172/0x1d9
[  808.424086]  [<c01c867e>] nfs_writepage_async+0x36/0x7e
[  808.429649]  [<c01c888f>] nfs_writepage+0x1a8/0x1dc
[  808.434851]  [<c017dd9b>] mpage_writepages+0x232/0x399
[  808.440326]  [<c01c88f1>] nfs_writepages+0x2e/0x11e
[  808.445529]  [<c01416f2>] do_writepages+0x2e/0x53
[  808.450552]  [<c017c072>] __sync_single_inode+0x60/0x1f1
[  808.456207]  [<c017c295>] __writeback_single_inode+0x92/0x195
[  808.462314]  [<c017c555>] sync_sb_inodes+0x1bd/0x2c2
[  808.467607]  [<c017c734>] writeback_inodes+0xda/0xe6
[  808.472900]  [<c01413e8>] background_writeout+0x69/0xa2
[  808.478465]  [<c0141e35>] __pdflush+0xc1/0x199
[  808.483216]  [<c0141f4d>] pdflush+0x40/0x47
[  808.487696]  [<c012fe68>] kthread+0xb7/0xbc
[  808.492176]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.497650] kswapd0       D 00000003     0   144      1           804    15 (L-TLB)
[  808.505971] f7dd8e14 f7dd8e04 00000004 00000003 f7dd8dac 00000004 00000001 c21ebd68 
[  808.514101]        c21ebd8c c2337a70 c21ebdd4 c21ebc00 00000202 c2227fe0 f7dd8e28 00000202 
[  808.523130]        c2227fe0 f7dd8e28 c2227560 00000003 00000132 ed120e86 000000bb c2337a70 
[  808.532160] Call Trace:
[  808.534945]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  808.540177]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  808.545677]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  808.551177]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  808.556766]  [<c014714d>] shrink_zone+0xe0/0xfa
[  808.562395]  [<c0147611>] balance_pgdat+0x286/0x37e
[  808.567538]  [<c01477ee>] kswapd+0xe5/0x10f
[  808.571965]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.577375] aio/0         S 00000002     0   145     15           146   143 (L-TLB)
[  808.585696] f7e34f34 f7e34f20 00000004 00000002 00000000 00000001 00000100 00000000 
[  808.593825]        00000080 00000080 00000080 c05566ac f7dd7550 c05566a0 c2217ec0 f7dd7550 
[  808.602889]        00000000 c220fec0 c220f560 00000000 0000013f 2ca67fde 00000000 f7dd7550 
[  808.611968] Call Trace:
[  808.614784]  [<c012bd90>] worker_thread+0x207/0x225
[  808.619988]  [<c012fe68>] kthread+0xb7/0xbc
[  808.624467]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.629941] aio/1         S 00000000     0   146     15           147   145 (L-TLB)
[  808.638263] f7e1df34 c2361030 c22175a8 00000000 00000000 00000001 00000100 00000000 
[  808.646485]        00000080 00000000 2ca50f66 00000000 c2361030 00000000 c220fec0 c2361030 
[  808.655616]        00000000 c2217ec0 c2217560 00000001 0000016c 2ca6bdf9 00000000 c2361030 
[  808.664722] Call Trace:
[  808.667537]  [<c012bd90>] worker_thread+0x207/0x225
[  808.672736]  [<c012fe68>] kthread+0xb7/0xbc
[  808.677212]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.682683] aio/2         S 00000004     0   147     15           148   146 (L-TLB)
[  808.691000] f7e35f34 f7e35f24 00000004 00000004 00000000 00000001 00000100 00000000 
[  808.699216]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  808.708341]        00000000 00000202 c221f560 00000002 000001a5 2ca71c86 00000000 c2330030 
[  808.717466] Call Trace:
[  808.720281]  [<c012bd90>] worker_thread+0x207/0x225
[  808.725482]  [<c012fe68>] kthread+0xb7/0xbc
[  808.729959]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.735429] aio/3         S 00000003     0   148     15           149   147 (L-TLB)
[  808.743746] f7e1ef34 f7e1ef24 00000004 00000003 00000000 00000001 00000100 00000080 
[  808.751877]        00000080 00000000 00000000 c05566a0 c05566a0 00000000 c220fec0 c220fec0 
[  808.760959]        00000000 00000202 c2227560 00000003 00000191 2ca776c8 00000000 c2337a70 
[  808.770040] Call Trace:
[  808.772841]  [<c012bd90>] worker_thread+0x207/0x225
[  808.778016]  [<c012fe68>] kthread+0xb7/0xbc
[  808.782470]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.787912] xfslogd/0     S 00000000     0   149     15           150   148 (L-TLB)
[  808.796234] f7e37f34 c2361030 c220f5a8 00000000 00000000 00000001 00000100 00000000 
[  808.804411]        00000100 00000080 2e49f705 00000000 c2361030 c05566a0 c2217ec0 c2361030 
[  808.813492]        00000000 c220fec0 c220f560 00000000 0000016d 2e4aa29a 00000000 c2361030 
[  808.822579] Call Trace:
[  808.825396]  [<c012bd90>] worker_thread+0x207/0x225
[  808.830600]  [<c012fe68>] kthread+0xb7/0xbc
[  808.835080]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.840554] xfslogd/1     S 00000001     0   150     15           151   149 (L-TLB)
[  808.848875] f7e75f34 f7e75f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  808.857097]        00000100 00000080 00000080 c05566a0 f7e36550 c05566ac c220fec0 f7e36550 
[  808.866228]        00000000 c2217ec0 c2217560 00000001 000000f4 2e4b28d6 00000000 f7e36550 
[  808.875357] Call Trace:
[  808.878173]  [<c012bd90>] worker_thread+0x207/0x225
[  808.883376]  [<c012fe68>] kthread+0xb7/0xbc
[  808.887856]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.893329] xfslogd/2     S 00000004     0   151     15           152   150 (L-TLB)
[  808.901650] f7e38f34 f7e38f24 00000004 00000004 00000000 00000001 00000100 00000080 
[  808.909872]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  808.919003]        00000000 00000202 c221f560 00000002 0000015d 2e4b69d2 00000000 c2330030 
[  808.928134] Call Trace:
[  808.930950]  [<c012bd90>] worker_thread+0x207/0x225
[  808.936153]  [<c012fe68>] kthread+0xb7/0xbc
[  808.940633]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.946106] xfslogd/3     S 00000003     0   152     15           153   151 (L-TLB)
[  808.954428] f7e76f34 f7e76f24 00000004 00000003 00000000 00000001 00000100 00000080 
[  808.962649]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  808.971782]        00000000 00000202 c2227560 00000003 00000173 2e4bc489 00000000 c2337a70 
[  808.980913] Call Trace:
[  808.983729]  [<c012bd90>] worker_thread+0x207/0x225
[  808.988932]  [<c012fe68>] kthread+0xb7/0xbc
[  808.993411]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  808.998885] xfsdatad/0    S 00000000     0   153     15           154   152 (L-TLB)
[  809.007206] f7e3af34 c2361030 c220f5a8 00000000 00000000 00000001 00000100 00000000 
[  809.015428]        00000100 00000080 2e4b784f 00000000 c2361030 c05566a0 c2217ec0 c2361030 
[  809.024560]        00000000 c220fec0 c220f560 00000000 00000131 2e4c227a 00000000 c2361030 
[  809.033653] Call Trace:
[  809.036453]  [<c012bd90>] worker_thread+0x207/0x225
[  809.041626]  [<c012fe68>] kthread+0xb7/0xbc
[  809.046080]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.051507] xfsdatad/1    S 00000001     0   154     15           155   153 (L-TLB)
[  809.059829] f7e78f34 f7e78f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  809.068030]        00000100 00000080 00000080 c05566a0 f7e3ba70 c05566ac c220fec0 f7e3ba70 
[  809.077112]        00000000 c2217ec0 c2217560 00000001 000000f6 2e4c9b2f 00000000 f7e3ba70 
[  809.086193] Call Trace:
[  809.088993]  [<c012bd90>] worker_thread+0x207/0x225
[  809.094167]  [<c012fe68>] kthread+0xb7/0xbc
[  809.098621]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.104064] xfsdatad/2    S 00000004     0   155     15           156   154 (L-TLB)
[  809.112385] f7e3cf34 f7e3cf24 00000004 00000004 00000000 00000001 00000100 00000080 
[  809.120562]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  809.129644]        00000000 00000202 c221f560 00000002 00000136 2e4cd917 00000000 c2330030 
[  809.138725] Call Trace:
[  809.141526]  [<c012bd90>] worker_thread+0x207/0x225
[  809.146699]  [<c012fe68>] kthread+0xb7/0xbc
[  809.151153]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.156595] xfsdatad/3    S 00000003     0   156     15           157   155 (L-TLB)
[  809.164917] f7e7af34 f7e7af24 00000004 00000003 00000000 00000001 00000100 00000080 
[  809.173139]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  809.182270]        00000000 00000202 c2227560 00000003 0000013e 2e4d313a 00000000 c2337a70 
[  809.191401] Call Trace:
[  809.194218]  [<c012bd90>] worker_thread+0x207/0x225
[  809.199419]  [<c012fe68>] kthread+0xb7/0xbc
[  809.203899]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.209372] xfsbufd       S 00000004     0   157     15           742   156 (L-TLB)
[  809.217693] f7e3df44 f7e3df34 00000004 00000004 00000100 00000080 00000080 00000000 
[  809.225916]        c2337a70 c2330030 af846c0b 000000a9 00000202 c221ffe0 f7e3df58 00000202 
[  809.235047]        c221ffe0 f7e3df58 c221f560 00000002 000000a9 cf3c7dbc 000000bb c2330030 
[  809.244178] Call Trace:
[  809.246994]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  809.252287]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  809.258845]  [<c0272754>] xfsbufd+0x4e/0x1b0
[  809.263416]  [<c012fe68>] kthread+0xb7/0xbc
[  809.267896]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.273371] kseriod       S 00000002     0   742     15          1514   157 (L-TLB)
[  809.281691] f7f16f5c f7f16f4c 00000004 00000002 c02eff05 c04b8f24 f7f16f10 c02efe91 
[  809.289868]        c04b8f08 c04a8738 c04b8f24 c04a63e0 f7f16f34 c02ef54e c04b8f08 c04a8738 
[  809.298950]        00000282 00000202 c220f560 00000000 000a8380 b437cbfc 00000000 c048db40 
[  809.308030] Call Trace:
[  809.310830]  [<c02e4762>] serio_thread+0xea/0xec
[  809.315735]  [<c012fe68>] kthread+0xb7/0xbc
[  809.320189]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.325631] kjournald     S 00000002     0   804      1          1519   144 (L-TLB)
[  809.333953] f7eaff58 f7eaff48 00000004 00000002 f726204c 00000000 00000000 f7fc6800 
[  809.342129]        00000000 f7171400 f7afcfa8 000003d0 00000202 c2217fe0 f7eaffb8 f7eaff2c 
[  809.351209]        f7fb086c f7fb0864 c220f560 00000000 000004a8 8a6284da 000000a6 c048db40 
[  809.361134] Call Trace:
[  809.363931]  [<c01b0eef>] kjournald+0x1d6/0x223
[  809.368746]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.374189] rpciod/0      D 00000002     0  1514     15          1515   742 (L-TLB)
[  809.382510] f7b96aa8 f7b96a98 00000004 00000002 f7ff8f18 00000001 00000003 00000b9d 
[  809.390687]        324272cc c048db40 02000000 f7e4f46c 00000202 c220ffe0 f7b96abc 00000202 
[  809.399767]        c220ffe0 f7b96abc c220f560 00000000 00000137 ed120e43 000000bb c048db40 
[  809.408849] Call Trace:
[  809.411649]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  809.416913]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  809.422446]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  809.427979]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  809.433602]  [<c014714d>] shrink_zone+0xe0/0xfa
[  809.438415]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  809.443408]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  809.448851]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  809.454024]  [<c03b74ad>] tcp_sendmsg+0xaa0/0xb78
[  809.459020]  [<c03d4666>] inet_sendmsg+0x48/0x53
[  809.463924]  [<c0388716>] sock_sendmsg+0xb8/0xd3
[  809.468829]  [<c0388773>] kernel_sendmsg+0x42/0x4f
[  809.473913]  [<c038bc00>] sock_no_sendpage+0x5e/0x77
[  809.479177]  [<c03ee7af>] xs_tcp_send_request+0x2af/0x375
[  809.484891]  [<c03ed4c5>] xprt_transmit+0x4f/0x20b
[  809.489975]  [<c03ebce1>] call_transmit+0x68/0xc8
[  809.494969]  [<c03f0962>] __rpc_execute+0x5c/0x1ea
[  809.500053]  [<c03f0b27>] rpc_async_schedule+0x11/0x15
[  809.505495]  [<c012bd1d>] worker_thread+0x194/0x225
[  809.510669]  [<c012fe68>] kthread+0xb7/0xbc
[  809.515123]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.520567] rpciod/1      S 00000001     0  1515     15          1516  1514 (L-TLB)
[  809.528890] f78dbf34 f78dbf20 00000004 00000001 00000000 c03ed2f0 f7b13fc0 00000000 
[  809.537066]        f7b13e00 c3a2e504 c3a2e504 00000000 f7d89a70 c03ebce1 c3a2e504 f7d89a70 
[  809.546148]        00000000 c2217ec0 c2217560 00000001 00002aff 0db3409e 000000aa f7d89a70 
[  809.555229] Call Trace:
[  809.558031]  [<c012bd90>] worker_thread+0x207/0x225
[  809.563205]  [<c012fe68>] kthread+0xb7/0xbc
[  809.567660]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.573103] rpciod/2      S 00000004     0  1516     15          1517  1515 (L-TLB)
[  809.581423] f7ba6f34 f7ba6f24 00000004 00000004 00000000 00000000 00000003 00000000 
[  809.589555]        c4866584 00000000 f7ba6eec c0296593 00000000 f7ba6f00 c04071af f7b13e00 
[  809.598583]        f71717b0 f71717a8 c221f560 00000002 000021eb af7442db 000000a9 c2330030 
[  809.607612] Call Trace:
[  809.610396]  [<c012bd90>] worker_thread+0x207/0x225
[  809.615539]  [<c012fe68>] kthread+0xb7/0xbc
[  809.619967]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.625377] rpciod/3      S 00000003     0  1517     15                1516 (L-TLB)
[  809.633698] f7154f34 f7154f20 00000004 00000003 00000000 00000000 00000003 00000000 
[  809.641827]        c2330030 00000000 f7154eec c0296593 f717b030 00000040 c04071af f717b030 
[  809.650858]        00000000 c2227ec0 c2227560 00000003 00003481 af9995ef 000000a9 f717b030 
[  809.659885] Call Trace:
[  809.662669]  [<c012bd90>] worker_thread+0x207/0x225
[  809.667811]  [<c012fe68>] kthread+0xb7/0xbc
[  809.672240]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.677650] portmap       S 00000002     0  1519      1          1541   804 (NOTLB)
[  809.685971] f717cf00 f717ceec 00000004 00000002 00000202 f7b8100c 00000202 00000000 
[  809.694100]        c2330550 f7b81000 f7e87080 00000202 f7e79030 00000003 f717ced0 f7e79030 
[  809.703128]        00000000 c220fec0 c220f560 00000000 0000c0e9 607461be 00000089 f7e79030 
[  809.712156] Call Trace:
[  809.714941]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  809.720173]  [<c016ce88>] do_poll+0x9a/0xb9
[  809.724601]  [<c016cffd>] sys_poll+0x156/0x221
[  809.729298]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  809.734618] kjournald     S 00000002     0  1541      1          1544  1519 (L-TLB)
[  809.742939] f71d3f58 f71d3f48 00000004 00000002 f724d02c 00000000 00000000 f71d1800 
[  809.751070]        00000000 f7171e00 f7afcd6c 0000020c 00000202 c220ffe0 f71d3fb8 f71d3f2c 
[  809.760116]        f7fb066c f7fb0664 c220f560 00000000 00000585 2cebc346 000000a7 c048db40 
[  809.769198] Call Trace:
[  809.771998]  [<c01b0eef>] kjournald+0x1d6/0x223
[  809.776813]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  809.782256] writetest     D 00000003     0  1544      1                1541 (NOTLB)
[  809.790577] f7adce10 f7adce00 00000004 00000003 f7adcdd4 f7ecfd80 f7adcde8 c01c7bcf 
[  809.798754]        f71b25c0 00000008 c01c7a21 f7adcdcc 00000082 f7b13600 f7adcdd4 f71b25c0 
[  809.807838]        f7adcdd4 f7adcdd4 c2227560 00000003 00000630 c562b75c 000000a9 c2337a70 
[  809.816918] Call Trace:
[  809.819719]  [<c040863b>] io_schedule+0x26/0x30
[  809.824532]  [<c013ab27>] sync_page+0x39/0x4e
[  809.829168]  [<c0408929>] __wait_on_bit_lock+0x58/0x67
[  809.834611]  [<c013b343>] __lock_page+0x84/0x8c
[  809.839425]  [<c013c3c9>] filemap_nopage+0x1e4/0x347
[  809.844688]  [<c014b4b4>] do_no_page+0x70/0x25b
[  809.849503]  [<c014b812>] __handle_mm_fault+0xef/0x22a
[  809.854945]  [<c0409a84>] do_page_fault+0x179/0x5e6
[  809.860119]  [<c01039cf>] error_code+0x4f/0x54

[  816.203560] SysRq : Show Memory
[  816.206914] Mem-info:
[  816.209316] DMA per-cpu:
[  816.212033] cpu 0 hot: low 0, high 0, batch 1 used:0
[  816.217238] cpu 0 cold: low 0, high 0, batch 1 used:0
[  816.222532] cpu 1 hot: low 0, high 0, batch 1 used:0
[  816.227737] cpu 1 cold: low 0, high 0, batch 1 used:0
[  816.233033] cpu 2 hot: low 0, high 0, batch 1 used:0
[  816.238237] cpu 2 cold: low 0, high 0, batch 1 used:0
[  816.243532] cpu 3 hot: low 0, high 0, batch 1 used:0
[  816.248736] cpu 3 cold: low 0, high 0, batch 1 used:0
[  816.254031] DMA32 per-cpu: empty
[  816.257470] Normal per-cpu:
[  816.260458] cpu 0 hot: low 0, high 186, batch 31 used:172
[  816.266115] cpu 0 cold: low 0, high 62, batch 15 used:7
[  816.271592] cpu 1 hot: low 0, high 186, batch 31 used:104
[  816.277249] cpu 1 cold: low 0, high 62, batch 15 used:29
[  816.282815] cpu 2 hot: low 0, high 186, batch 31 used:10
[  816.288379] cpu 2 cold: low 0, high 62, batch 15 used:14
[  816.293945] cpu 3 hot: low 0, high 186, batch 31 used:18
[  816.299509] cpu 3 cold: low 0, high 62, batch 15 used:57
[  816.305072] HighMem per-cpu:
[  816.308150] cpu 0 hot: low 0, high 186, batch 31 used:118
[  816.313805] cpu 0 cold: low 0, high 62, batch 15 used:12
[  816.319370] cpu 1 hot: low 0, high 186, batch 31 used:26
[  816.324933] cpu 1 cold: low 0, high 62, batch 15 used:61
[  816.330498] cpu 2 hot: low 0, high 186, batch 31 used:92
[  816.336062] cpu 2 cold: low 0, high 62, batch 15 used:14
[  816.341626] cpu 3 hot: low 0, high 186, batch 31 used:160
[  816.347282] cpu 3 cold: low 0, high 62, batch 15 used:48
[  816.352848] Free pages:       10336kB (3008kB HighMem)
[  816.358232] Active:462053 inactive:37639 dirty:164757 writeback:302602 unstable:0 free:2584 slab:13246 mapped:1247 pagetables:10
[  816.370311] DMA free:3588kB min:68kB low:84kB high:100kB active:2696kB inactive:512kB present:16384kB pages_scanned:33 all_unreclaimable? no
[  816.383472] lowmem_reserve[]: 0 0 880 2031
[  816.387989] DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[  816.399742] lowmem_reserve[]: 0 0 880 2031
[  816.404212] Normal free:3740kB min:3756kB low:4692kB high:5632kB active:747500kB inactive:74408kB present:901120kB pages_scanned:96 all_unreclaimable? no
[  816.418389] lowmem_reserve[]: 0 0 0 9211
[  816.422680] HighMem free:3008kB min:512kB low:1740kB high:2968kB active:1098016kB inactive:75636kB present:1179092kB pages_scanned:0 all_unreclaimable? no
[  816.436944] lowmem_reserve[]: 0 0 0 0
[  816.440965] DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
[  816.451733] DMA32: empty
[  816.454419] Normal: 1*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3740kB
[  816.465455] HighMem: 60*4kB 40*8kB 17*16kB 8*32kB 4*64kB 3*128kB 1*256kB 2*512kB 0*1024kB 0*2048kB 0*4096kB = 3008kB
[  816.476852] Swap cache: add 0, delete 0, find 0/0, race 0+0
[  816.482623] Free swap  = 0kB
[  816.485624] Total swap = 0kB
[  816.488624] Free swap:            0kB
[  816.500924] 524149 pages of RAM
[  816.504196] 294773 pages of HIGHMEM
[  816.507822] 6073 reserved pages
[  816.511091] 304404 pages shared
[  816.514360] 0 pages swap cached
[  816.517630] 164757 pages dirty
[  816.520809] 302602 pages writeback
[  816.524347] 1247 pages mapped
[  816.527437] 13246 pages slab
[  816.530438] 10 pages pagetables
[  865.060642] SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
[  871.180739] SysRq : Kill All Tasks


[  891.618438] SysRq : Terminate All Tasks


[  913.929600] SysRq : Show Regs
[  913.932773] 
[  913.934362] Pid: 0, comm:              swapper
[  913.939025] EIP: 0060:[<c0100d4f>] CPU: 0
[  913.943240] EIP is at default_idle+0x36/0x56
[  913.947724]  EFLAGS: 00000246    Not tainted  (2.6.15-rc5+nfs+k2)
[  913.954105] EAX: 00000000 EBX: c0503000 ECX: c220e2e0 EDX: c0503000
[  913.960666] ESI: c053c380 EDI: c053c300 EBP: c0503fac DS: 007b ES: 007b
[  913.967634] CR0: 8005003b CR2: b7afd000 CR3: 00540000 CR4: 000006d0
[  915.322037] SysRq : Show State
[  915.325299] 
[  915.325300]                                                sibling
[  915.333359]   task             PC      pid father child younger older
[  915.340102] bash          S 00000001     0     1      0     2               (NOTLB)
[  915.348424] c2331f08 c2331ef8 00000004 00000001 00000092 f717ba70 f717ba70 f717ba70 
[  915.356645]        c2331ed0 c011d794 f717ba70 000200d2 00000000 00000000 f717ba70 000005ef 
[  915.365776]        00000000 c2331f08 c2217560 00000001 0000083d d6a485f6 000000ca c2330550 
[  915.374907] Call Trace:
[  915.377722]  [<c011fa57>] do_wait+0x18a/0x376
[  915.382382]  [<c011fd03>] sys_wait4+0x3e/0x42
[  915.387040]  [<c011fd2e>] sys_waitpid+0x27/0x2b
[  915.391878]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  915.397259] migration/0   S 00000002     0     2      1             3       (L-TLB)
[  915.405576] c2339f94 c2339f84 00000004 00000002 c0116b9c c2337a70 c22275a8 00000001 
[  915.413793]        c220f5ac 00000001 00000073 c220f958 c220f958 c22275a8 c220f5a8 00000000 
[  915.422918]        c2227560 00000003 c220f560 00000000 000017c2 aa8db191 000000a9 c048db40 
[  915.432045] Call Trace:
[  915.434859]  [<c0118d0c>] migration_thread+0x81/0x10d
[  915.440242]  [<c012fe68>] kthread+0xb7/0xbc
[  915.444720]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.450189] ksoftirqd/0   S 00000000     0     3      1             4     2 (L-TLB)
[  915.458511] c233af98 c2337030 c220f560 00000000 000004db 000e078d 00000000 c233ba70 
[  915.466641]        c2337030 c233715c 00000001 c2331f5c c2330a70 ffffffff c2337030 c233af6c 
[  915.475671]        00000000 00000000 c220f560 00000000 000002b2 000ea053 00000000 c2330a70 
[  915.484700] Call Trace:
[  915.487485]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  915.492093]  [<c012fe68>] kthread+0xb7/0xbc
[  915.496522]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.501997] migration/1   S 00000001     0     4      1             5     3 (L-TLB)
[  915.510319] c233cf94 c233cf80 00000004 00000001 00000082 00000001 c233cf44 00000000 
[  915.518541]        c048db40 c2337a70 00000003 c2227560 c2330a70 00000009 00000008 c2330a70 
[  915.527674]        00000000 c2217ec0 c2217560 00000001 00000eaf 3827d003 000000a1 c2330a70 
[  915.536805] Call Trace:
[  915.539621]  [<c0118d0c>] migration_thread+0x81/0x10d
[  915.545007]  [<c012fe68>] kthread+0xb7/0xbc
[  915.549486]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.554961] ksoftirqd/1   S 00000001     0     5      1             6     4 (L-TLB)
[  915.563281] c2345f98 c2345f88 00000004 00000001 000000c7 00180089 00000000 c233b550 
[  915.571503]        c233b550 c2330a70 00000001 c2331f28 c2345000 ffffffff c233b550 c2345f6c 
[  915.580635]        c0407ed4 c22175a8 c2217560 00000001 00000177 2fc9a4b5 00000000 c2330550 
[  915.589767] Call Trace:
[  915.592577]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  915.597185]  [<c012fe68>] kthread+0xb7/0xbc
[  915.601612]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.607023] migration/2   S 00000004     0     6      1             7     5 (L-TLB)
[  915.615343] c2346f94 c2346f80 00000004 00000004 00000082 c2330550 c22175a8 00000000 
[  915.623473]        c2337a70 c2330550 00000001 c2217560 f7e79030 00000002 00000002 f7e79030 
[  915.632501]        00000000 c221fec0 c221f560 00000002 00000c37 37d42ab3 00000058 f7e79030 
[  915.641529] Call Trace:
[  915.644314]  [<c0118d0c>] migration_thread+0x81/0x10d
[  915.649638]  [<c012fe68>] kthread+0xb7/0xbc
[  915.654066]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.659476] ksoftirqd/2   S 00000002     0     7      1             8     6 (L-TLB)
[  915.667798] c234df98 c234ca70 c221f560 00000002 00000163 00275526 00000000 c234ca70 
[  915.675975]        c234ca70 c234cb9c 00000001 c2331f28 c234d000 ffffffff c234ca70 c234df6c 
[  915.685055]        c0407ed4 c221f5a8 c221f560 00000002 00000043 00275786 00000000 c2330030 
[  915.694136] Call Trace:
[  915.696936]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  915.701569]  [<c012fe68>] kthread+0xb7/0xbc
[  915.706023]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.711465] migration/3   S 00000003     0     8      1             9     7 (L-TLB)
[  915.719786] c234ef94 c234ef80 00000004 00000003 00000082 00000001 c234ef44 00000000 
[  915.727961]        c2330030 c2330550 00000001 c2217560 f70f8030 00000011 00000002 f70f8030 
[  915.737042]        00000000 c2227ec0 c2227560 00000003 0000105f 353ed25e 00000058 f70f8030 
[  915.746123] Call Trace:
[  915.748923]  [<c0118d0c>] migration_thread+0x81/0x10d
[  915.754277]  [<c012fe68>] kthread+0xb7/0xbc
[  915.758731]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.764173] ksoftirqd/3   S 00000003     0     9      1            10     8 (L-TLB)
[  915.772495] c2353f98 c2353f88 00000004 00000003 000000c9 00367434 00000000 c234c030 
[  915.780670]        c234c030 c2361550 00000001 c2331f28 c2353000 ffffffff c234c030 c2353f6c 
[  915.789752]        c0407ed4 c22275a8 c2227560 00000003 00000182 364e7604 00000058 c2337a70 
[  915.798831] Call Trace:
[  915.801645]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  915.806303]  [<c012fe68>] kthread+0xb7/0xbc
[  915.810781]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.816251] events/0      R running     0    10      1            11     9 (L-TLB)
[  915.824477] events/1      S 00000001     0    11      1            12    10 (L-TLB)
[  915.832792] c236af34 c236af24 00000004 00000001 00000202 00000001 c2354540 000007d0 
[  915.841010]        c236aef4 c012bb5c c22191b8 00095bff c23518d0 c2300780 00000002 c236aefc 
[  915.850135]        c2348930 c2348928 c2217560 00000001 00000923 c8d49673 000000d4 c2330550 
[  915.859262] Call Trace:
[  915.862076]  [<c012bd90>] worker_thread+0x207/0x225
[  915.867276]  [<c012fe68>] kthread+0xb7/0xbc
[  915.871754]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.877224] events/2      S 00000004     0    12      1            13    11 (L-TLB)
[  915.885541] c2359f34 c2359f24 00000004 00000004 00000202 00000001 c2354540 000007d0 
[  915.893759]        c2359ef4 c012bb5c c22211b8 00095c02 00000000 c2300780 c22211a4 c2359efc 
[  915.902885]        c23488b0 c23488a8 c221f560 00000002 000007dd c902406c 000000d4 c2330030 
[  915.912011] Call Trace:
[  915.914826]  [<c012bd90>] worker_thread+0x207/0x225
[  915.920025]  [<c012fe68>] kthread+0xb7/0xbc
[  915.924501]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.929971] events/3      S 00000003     0    13      1            14    12 (L-TLB)
[  915.938287] c236cf34 c236cf24 00000004 00000003 00000202 00000001 c2354540 000007d0 
[  915.946504]        c236cef4 c012bb5c c22291b8 00095c03 00000000 c2300780 c22291a4 c236cefc 
[  915.955631]        c2348830 c2348828 c2227560 00000003 00000533 c9115d4f 000000d4 c2337a70 
[  915.964755] Call Trace:
[  915.967570]  [<c012bd90>] worker_thread+0x207/0x225
[  915.972769]  [<c012fe68>] kthread+0xb7/0xbc
[  915.977246]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  915.982717] khelper       S 00000004     0    14      1            15    13 (L-TLB)
[  915.991016] c235af34 c235af24 00000004 00000004 00000000 c235aef4 c0117b5d f7ba3c70 
[  915.999141]        00000003 00000000 00000000 f7ba3d00 f7ba3cf4 f7ba3cf8 00000202 c235af1c 
[  916.008162]        c23487b0 c23487a8 c221f560 00000002 000001db da3e6193 00000056 c2330030 
[  916.017185] Call Trace:
[  916.019968]  [<c012bd90>] worker_thread+0x207/0x225
[  916.025107]  [<c012fe68>] kthread+0xb7/0xbc
[  916.029532]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.034939] kthread       S 00000001     0    15      1    20     144    14 (L-TLB)
[  916.043161] c2389f34 c2389f24 00000004 00000001 c2389ef0 c0117b5d f78ebd80 00000003 
[  916.051285]        00000000 00000000 f78ebe20 f78ebe14 f78ebe18 00000202 c2389f18 c0117cbb 
[  916.060309]        c2380b30 c2380b28 c2217560 00000001 00000187 fa724d73 00000066 c2330550 
[  916.070150] Call Trace:
[  916.072933]  [<c012bd90>] worker_thread+0x207/0x225
[  916.078072]  [<c012fe68>] kthread+0xb7/0xbc
[  916.082498]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.087905] kblockd/0     S 00000002     0    20     15            21       (L-TLB)
[  916.096128] c238bf34 c238bf20 00000004 00000002 c238bed0 c040906a c238bef8 00000000 
[  916.104252]        c0579414 f7f7aedc c238bee8 00000000 f7a95a70 f7f734f4 c23eef80 f7a95a70 
[  916.113276]        00000000 c220fec0 c220f560 00000000 000017d6 aee7a4ca 000000a9 f7a95a70 
[  916.122300] Call Trace:
[  916.125083]  [<c012bd90>] worker_thread+0x207/0x225
[  916.130224]  [<c012fe68>] kthread+0xb7/0xbc
[  916.134650]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.140057] kblockd/1     S 00000001     0    21     15            22    20 (L-TLB)
[  916.148280] f7d58f34 f7d58f24 00000004 00000001 f7d58ed0 c040906a f7d58ef8 c02fccc2 
[  916.156407]        c0579414 f7f7ac5c f7d58ee8 00000000 c23eef00 f7f734f4 c23eef00 f7f7359c 
[  916.165430]        c23eef30 c23eef28 c2217560 00000001 00000c15 9a287d8b 00000091 c2330550 
[  916.174455] Call Trace:
[  916.177269]  [<c012bd90>] worker_thread+0x207/0x225
[  916.182471]  [<c012fe68>] kthread+0xb7/0xbc
[  916.186947]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.192417] kblockd/2     S 00000004     0    22     15            23    21 (L-TLB)
[  916.200733] c238ff34 c238ff24 00000004 00000004 c238fed0 c040906a c238fef8 c02fccc2 
[  916.208950]        c0579414 d6cb69dc 00000080 00000000 c23eee80 f7f734f4 c23eee80 f7f7359c 
[  916.218076]        c23eeeb0 c23eeea8 c221f560 00000002 000011d4 afbc9d2d 000000a9 c2330030 
[  916.227201] Call Trace:
[  916.230015]  [<c012bd90>] worker_thread+0x207/0x225
[  916.235215]  [<c012fe68>] kthread+0xb7/0xbc
[  916.239692]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.245162] kblockd/3     S 00000003     0    23     15            24    22 (L-TLB)
[  916.253452] f7d59f34 f7d59f24 00000004 00000003 f7f7a2fc 000b884f 00000000 00000202 
[  916.261573]        00000001 f7f7a2fc f7d59ee8 c040906a f7d59f10 c02fccc2 c0579414 f7f7a2fc 
[  916.270594]        c23eee30 c23eee28 c2227560 00000003 00000d8c 29f94785 0000003a c2337a70 
[  916.279616] Call Trace:
[  916.282398]  [<c012bd90>] worker_thread+0x207/0x225
[  916.287539]  [<c012fe68>] kthread+0xb7/0xbc
[  916.291964]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.297372] kacpid        S 00000002     0    24     15           142    23 (L-TLB)
[  916.305592] f7d78f34 f7d78f24 00000004 00000002 00000000 00000001 00000100 00000000 
[  916.313712]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  916.322730]        00000000 00000202 c220f560 00000000 00000189 027f7e52 00000000 c048db40 
[  916.331748] Call Trace:
[  916.334530]  [<c012bd90>] worker_thread+0x207/0x225
[  916.339668]  [<c012fe68>] kthread+0xb7/0xbc
[  916.344091]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.349496] pdflush       S 00000002     0   142     15           143    24 (L-TLB)
[  916.357714] f7d5df68 f7d5df58 00000004 00000002 c0124c50 c0493a5c 0009659d f7d5df68 
[  916.365835]        c014153c c0493a5c 0009659d 0008dce5 00000000 00000000 f7d5df18 00000400 
[  916.374856]        00000000 00000000 c220f560 00000000 000001ac a8ca9576 000000d4 c048db40 
[  916.383874] Call Trace:
[  916.386656]  [<c0141df8>] __pdflush+0x84/0x199
[  916.391348]  [<c0141f4d>] pdflush+0x40/0x47
[  916.395771]  [<c012fe68>] kthread+0xb7/0xbc
[  916.400195]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.405599] pdflush       D 00000001     0   143     15           145   142 (L-TLB)
[  916.413816] f7d8aa48 f7d8aa38 00000004 00000001 f7d8aa34 00000202 f7d8a9f8 c01302cf 
[  916.421936]        f7b26080 c2330550 f7d8aa28 f7d8aa54 00000202 c2217fe0 f7d8aa5c 00000202 
[  916.430954]        c2217fe0 f7d8aa5c c2217560 00000001 0000011b 1a87fa49 000000d5 c2330550 
[  916.439974] Call Trace:
[  916.442755]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  916.447982]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  916.453476]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  916.458972]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  916.464555]  [<c014714d>] shrink_zone+0xe0/0xfa
[  916.469336]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  916.474295]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  916.479699]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  916.484836]  [<c0142d35>] kmem_getpages+0x34/0x9d
[  916.489796]  [<c0143b91>] cache_grow+0xaf/0x16c
[  916.494578]  [<c0143db2>] cache_alloc_refill+0x164/0x207
[  916.500163]  [<c014403b>] kmem_cache_alloc+0x4e/0x50
[  916.505389]  [<c01c4e05>] nfs_create_request+0x3d/0xcc
[  916.510794]  [<c01c9151>] nfs_update_request+0x172/0x1d9
[  916.516377]  [<c01c867e>] nfs_writepage_async+0x36/0x7e
[  916.521871]  [<c01c888f>] nfs_writepage+0x1a8/0x1dc
[  916.527007]  [<c017dd9b>] mpage_writepages+0x232/0x399
[  916.532413]  [<c01c88f1>] nfs_writepages+0x2e/0x11e
[  916.537551]  [<c01416f2>] do_writepages+0x2e/0x53
[  916.542510]  [<c017c072>] __sync_single_inode+0x60/0x1f1
[  916.548094]  [<c017c295>] __writeback_single_inode+0x92/0x195
[  916.554124]  [<c017c555>] sync_sb_inodes+0x1bd/0x2c2
[  916.559350]  [<c017c734>] writeback_inodes+0xda/0xe6
[  916.564578]  [<c01413e8>] background_writeout+0x69/0xa2
[  916.570072]  [<c0141e35>] __pdflush+0xc1/0x199
[  916.574763]  [<c0141f4d>] pdflush+0x40/0x47
[  916.579186]  [<c012fe68>] kthread+0xb7/0xbc
[  916.583609]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.589014] kswapd0       D 00000003     0   144      1           804    15 (L-TLB)
[  916.597234] f7dd8e14 f7dd8e04 00000004 00000003 f7dd8dac 00000004 00000001 c21ebd68 
[  916.605355]        c21ebd8c c2337a70 c21ebdd4 c21ebc00 00000202 c2227fe0 f7dd8e28 00000202 
[  916.614374]        c2227fe0 f7dd8e28 c2227560 00000003 00000136 1a87e819 000000d5 c2337a70 
[  916.623394] Call Trace:
[  916.626176]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  916.631403]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  916.636900]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  916.642395]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  916.647978]  [<c014714d>] shrink_zone+0xe0/0xfa
[  916.652759]  [<c0147611>] balance_pgdat+0x286/0x37e
[  916.657896]  [<c01477ee>] kswapd+0xe5/0x10f
[  916.662320]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.667724] aio/0         S 00000002     0   145     15           146   143 (L-TLB)
[  916.675944] f7e34f34 f7e34f20 00000004 00000002 00000000 00000001 00000100 00000000 
[  916.684064]        00000080 00000080 00000080 c05566ac f7dd7550 c05566a0 c2217ec0 f7dd7550 
[  916.693084]        00000000 c220fec0 c220f560 00000000 0000013f 2ca67fde 00000000 f7dd7550 
[  916.702102] Call Trace:
[  916.704884]  [<c012bd90>] worker_thread+0x207/0x225
[  916.710021]  [<c012fe68>] kthread+0xb7/0xbc
[  916.714444]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.719850] aio/1         S 00000000     0   146     15           147   145 (L-TLB)
[  916.728070] f7e1df34 c2361030 c22175a8 00000000 00000000 00000001 00000100 00000000 
[  916.736192]        00000080 00000000 2ca50f66 00000000 c2361030 00000000 c220fec0 c2361030 
[  916.745215]        00000000 c2217ec0 c2217560 00000001 0000016c 2ca6bdf9 00000000 c2361030 
[  916.754233] Call Trace:
[  916.757014]  [<c012bd90>] worker_thread+0x207/0x225
[  916.762151]  [<c012fe68>] kthread+0xb7/0xbc
[  916.766574]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.771979] aio/2         S 00000004     0   147     15           148   146 (L-TLB)
[  916.780198] f7e35f34 f7e35f24 00000004 00000004 00000000 00000001 00000100 00000000 
[  916.788317]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  916.797334]        00000000 00000202 c221f560 00000002 000001a5 2ca71c86 00000000 c2330030 
[  916.806353] Call Trace:
[  916.809134]  [<c012bd90>] worker_thread+0x207/0x225
[  916.814271]  [<c012fe68>] kthread+0xb7/0xbc
[  916.818695]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.824099] aio/3         S 00000003     0   148     15           149   147 (L-TLB)
[  916.832317] f7e1ef34 f7e1ef24 00000004 00000003 00000000 00000001 00000100 00000080 
[  916.840438]        00000080 00000000 00000000 c05566a0 c05566a0 00000000 c220fec0 c220fec0 
[  916.849457]        00000000 00000202 c2227560 00000003 00000191 2ca776c8 00000000 c2337a70 
[  916.858475] Call Trace:
[  916.861256]  [<c012bd90>] worker_thread+0x207/0x225
[  916.866393]  [<c012fe68>] kthread+0xb7/0xbc
[  916.871618]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.877023] xfslogd/0     S 00000000     0   149     15           150   148 (L-TLB)
[  916.885241] f7e37f34 c2361030 c220f5a8 00000000 00000000 00000001 00000100 00000000 
[  916.893361]        00000100 00000080 2e49f705 00000000 c2361030 c05566a0 c2217ec0 c2361030 
[  916.902383]        00000000 c220fec0 c220f560 00000000 0000016d 2e4aa29a 00000000 c2361030 
[  916.911401] Call Trace:
[  916.914183]  [<c012bd90>] worker_thread+0x207/0x225
[  916.919319]  [<c012fe68>] kthread+0xb7/0xbc
[  916.923742]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.929147] xfslogd/1     S 00000001     0   150     15           151   149 (L-TLB)
[  916.937365] f7e75f34 f7e75f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  916.945486]        00000100 00000080 00000080 c05566a0 f7e36550 c05566ac c220fec0 f7e36550 
[  916.954505]        00000000 c2217ec0 c2217560 00000001 000000f4 2e4b28d6 00000000 f7e36550 
[  916.963525] Call Trace:
[  916.966306]  [<c012bd90>] worker_thread+0x207/0x225
[  916.971443]  [<c012fe68>] kthread+0xb7/0xbc
[  916.975867]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  916.981271] xfslogd/2     S 00000004     0   151     15           152   150 (L-TLB)
[  916.989489] f7e38f34 f7e38f24 00000004 00000004 00000000 00000001 00000100 00000080 
[  916.997609]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  917.006626]        00000000 00000202 c221f560 00000002 0000015d 2e4b69d2 00000000 c2330030 
[  917.015643] Call Trace:
[  917.018424]  [<c012bd90>] worker_thread+0x207/0x225
[  917.023563]  [<c012fe68>] kthread+0xb7/0xbc
[  917.027988]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.033393] xfslogd/3     S 00000003     0   152     15           153   151 (L-TLB)
[  917.041612] f7e76f34 f7e76f24 00000004 00000003 00000000 00000001 00000100 00000080 
[  917.049733]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  917.058751]        00000000 00000202 c2227560 00000003 00000173 2e4bc489 00000000 c2337a70 
[  917.067770] Call Trace:
[  917.070552]  [<c012bd90>] worker_thread+0x207/0x225
[  917.075689]  [<c012fe68>] kthread+0xb7/0xbc
[  917.080112]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.085517] xfsdatad/0    S 00000000     0   153     15           154   152 (L-TLB)
[  917.093734] f7e3af34 c2361030 c220f5a8 00000000 00000000 00000001 00000100 00000000 
[  917.101897]        00000100 00000080 2e4b784f 00000000 c2361030 c05566a0 c2217ec0 c2361030 
[  917.110914]        00000000 c220fec0 c220f560 00000000 00000131 2e4c227a 00000000 c2361030 
[  917.119982] Call Trace:
[  917.122783]  [<c012bd90>] worker_thread+0x207/0x225
[  917.127957]  [<c012fe68>] kthread+0xb7/0xbc
[  917.132412]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.137855] xfsdatad/1    S 00000001     0   154     15           155   153 (L-TLB)
[  917.146175] f7e78f34 f7e78f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  917.154352]        00000100 00000080 00000080 c05566a0 f7e3ba70 c05566ac c220fec0 f7e3ba70 
[  917.163434]        00000000 c2217ec0 c2217560 00000001 000000f6 2e4c9b2f 00000000 f7e3ba70 
[  917.172519] Call Trace:
[  917.175319]  [<c012bd90>] worker_thread+0x207/0x225
[  917.180493]  [<c012fe68>] kthread+0xb7/0xbc
[  917.184948]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.190391] xfsdatad/2    S 00000004     0   155     15           156   154 (L-TLB)
[  917.198714] f7e3cf34 f7e3cf24 00000004 00000004 00000000 00000001 00000100 00000080 
[  917.206892]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  917.215972]        00000000 00000202 c221f560 00000002 00000136 2e4cd917 00000000 c2330030 
[  917.225063] Call Trace:
[  917.227879]  [<c012bd90>] worker_thread+0x207/0x225
[  917.233081]  [<c012fe68>] kthread+0xb7/0xbc
[  917.237560]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.243034] xfsdatad/3    S 00000003     0   156     15           157   155 (L-TLB)
[  917.251357] f7e7af34 f7e7af24 00000004 00000003 00000000 00000001 00000100 00000080 
[  917.259486]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  917.268514]        00000000 00000202 c2227560 00000003 0000013e 2e4d313a 00000000 c2337a70 
[  917.277566] Call Trace:
[  917.280365]  [<c012bd90>] worker_thread+0x207/0x225
[  917.285538]  [<c012fe68>] kthread+0xb7/0xbc
[  917.289991]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.295434] xfsbufd       S 00000004     0   157     15           742   156 (L-TLB)
[  917.303756] f7e3df44 f7e3df34 00000004 00000004 00000100 00000080 00000080 00000000 
[  917.311931]        c2337a70 c2330030 af846c0b 000000a9 00000202 c221ffe0 f7e3df58 00000202 
[  917.321011]        c221ffe0 f7e3df58 c221f560 00000002 0000009c fd694784 000000d4 c2330030 
[  917.330093] Call Trace:
[  917.332893]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  917.338155]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  917.344677]  [<c0272754>] xfsbufd+0x4e/0x1b0
[  917.349221]  [<c012fe68>] kthread+0xb7/0xbc
[  917.353675]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.359118] kseriod       S 00000002     0   742     15          1514   157 (L-TLB)
[  917.367440] f7f16f5c f7f16f4c 00000004 00000002 c02eff05 c04b8f24 f7f16f10 c02efe91 
[  917.375616]        c04b8f08 c04a8738 c04b8f24 c04a63e0 f7f16f34 c02ef54e c04b8f08 c04a8738 
[  917.384696]        00000282 00000202 c220f560 00000000 000a8380 b437cbfc 00000000 c048db40 
[  917.393776] Call Trace:
[  917.396576]  [<c02e4762>] serio_thread+0xea/0xec
[  917.401481]  [<c012fe68>] kthread+0xb7/0xbc
[  917.405934]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.411375] kjournald     S 00000002     0   804      1          1541   144 (L-TLB)
[  917.419696] f7eaff58 f7eaff48 00000004 00000002 f726204c 00000000 00000000 f7fc6800 
[  917.427860]        00000000 f7171400 f7afcfa8 000003d0 00000202 c2217fe0 f7eaffb8 f7eaff2c 
[  917.436888]        f7fb086c f7fb0864 c220f560 00000000 000004a8 8a6284da 000000a6 c048db40 
[  917.445918] Call Trace:
[  917.448703]  [<c01b0eef>] kjournald+0x1d6/0x223
[  917.453490]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.458917] rpciod/0      D 00000002     0  1514     15          1515   742 (L-TLB)
[  917.467239] f7b96aa8 f7b96a98 00000004 00000002 f7ff8f18 00000001 00000003 00000b9d 
[  917.475462]        324272cc c048db40 02000000 f7e4f46c 00000202 c220ffe0 f7b96abc 00000202 
[  917.484593]        c220ffe0 f7b96abc c220f560 00000000 0000012c 1a87e85c 000000d5 c048db40 
[  917.493725] Call Trace:
[  917.496542]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  917.501835]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  917.507400]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  917.512965]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  917.518619]  [<c014714d>] shrink_zone+0xe0/0xfa
[  917.523461]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  917.528483]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  917.533956]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  917.539159]  [<c03b74ad>] tcp_sendmsg+0xaa0/0xb78
[  917.544182]  [<c03d4666>] inet_sendmsg+0x48/0x53
[  917.549114]  [<c0388716>] sock_sendmsg+0xb8/0xd3
[  917.554047]  [<c0388773>] kernel_sendmsg+0x42/0x4f
[  917.559159]  [<c038bc00>] sock_no_sendpage+0x5e/0x77
[  917.564452]  [<c03ee7af>] xs_tcp_send_request+0x2af/0x375
[  917.570199]  [<c03ed4c5>] xprt_transmit+0x4f/0x20b
[  917.575312]  [<c03ebce1>] call_transmit+0x68/0xc8
[  917.580334]  [<c03f0962>] __rpc_execute+0x5c/0x1ea
[  917.585445]  [<c03f0b27>] rpc_async_schedule+0x11/0x15
[  917.590920]  [<c012bd1d>] worker_thread+0x194/0x225
[  917.596123]  [<c012fe68>] kthread+0xb7/0xbc
[  917.600602]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.606076] rpciod/1      S 00000001     0  1515     15          1516  1514 (L-TLB)
[  917.614398] f78dbf34 f78dbf20 00000004 00000001 00000000 c03ed2f0 f7b13fc0 00000000 
[  917.622620]        f7b13e00 c3a2e504 c3a2e504 00000000 f7d89a70 c03ebce1 c3a2e504 f7d89a70 
[  917.631752]        00000000 c2217ec0 c2217560 00000001 00002aff 0db3409e 000000aa f7d89a70 
[  917.640885] Call Trace:
[  917.643702]  [<c012bd90>] worker_thread+0x207/0x225
[  917.648904]  [<c012fe68>] kthread+0xb7/0xbc
[  917.653384]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.658837] rpciod/2      S 00000004     0  1516     15          1517  1515 (L-TLB)
[  917.667159] f7ba6f34 f7ba6f24 00000004 00000004 00000000 00000000 00000003 00000000 
[  917.675333]        c4866584 00000000 f7ba6eec c0296593 00000000 f7ba6f00 c04071af f7b13e00 
[  917.685250]        f71717b0 f71717a8 c221f560 00000002 000021eb af7442db 000000a9 c2330030 
[  917.694331] Call Trace:
[  917.697132]  [<c012bd90>] worker_thread+0x207/0x225
[  917.702304]  [<c012fe68>] kthread+0xb7/0xbc
[  917.706758]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.712177] rpciod/3      S 00000003     0  1517     15                1516 (L-TLB)
[  917.720499] f7154f34 f7154f20 00000004 00000003 00000000 00000000 00000003 00000000 
[  917.728627]        c2330030 00000000 f7154eec c0296593 f717b030 00000040 c04071af f717b030 
[  917.737686]        00000000 c2227ec0 c2227560 00000003 00003481 af9995ef 000000a9 f717b030 
[  917.746718] Call Trace:
[  917.749502]  [<c012bd90>] worker_thread+0x207/0x225
[  917.754644]  [<c012fe68>] kthread+0xb7/0xbc
[  917.759072]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.764482] kjournald     S 00000002     0  1541      1          1544   804 (L-TLB)
[  917.772805] f71d3f58 f71d3f48 00000004 00000002 f724d02c 00000000 00000000 f71d1800 
[  917.780935]        00000000 f7171e00 f7afcd6c 0000020c 00000202 c220ffe0 f71d3fb8 f71d3f2c 
[  917.789964]        f7fb066c f7fb0664 c220f560 00000000 00000585 2cebc346 000000a7 c048db40 
[  917.798993] Call Trace:
[  917.801778]  [<c01b0eef>] kjournald+0x1d6/0x223
[  917.806564]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  917.811974] writetest     D 00000003     0  1544      1                1541 (NOTLB)
[  917.820295] f7adce10 f7adce00 00000004 00000003 f7adcdd4 f7ecfd80 f7adcde8 c01c7bcf 
[  917.828424]        f71b25c0 00000008 c01c7a21 f7adcdcc 00000082 f7b13600 f7adcdd4 f71b25c0 
[  917.837453]        f7adcdd4 f7adcdd4 c2227560 00000003 00000630 c562b75c 000000a9 c2337a70 
[  917.846483] Call Trace:
[  917.849268]  [<c040863b>] io_schedule+0x26/0x30
[  917.854053]  [<c013ab27>] sync_page+0x39/0x4e
[  917.858662]  [<c0408929>] __wait_on_bit_lock+0x58/0x67
[  917.864073]  [<c013b343>] __lock_page+0x84/0x8c
[  917.868858]  [<c013c3c9>] filemap_nopage+0x1e4/0x347
[  917.874089]  [<c014b4b4>] do_no_page+0x70/0x25b
[  917.878876]  [<c014b812>] __handle_mm_fault+0xef/0x22a
[  917.884286]  [<c0409a84>] do_page_fault+0x179/0x5e6
[  917.889429]  [<c01039cf>] error_code+0x4f/0x54
[  932.729798] SysRq : Emergency Sync
[  932.733470] Emergency Sync complete
[  936.457722] Restarting system.
[  936.460951] .

--0-1860124575-1133819470=:87387--
