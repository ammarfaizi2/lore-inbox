Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVKNOeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVKNOeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 09:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVKNOeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 09:34:15 -0500
Received: from barclay.balt.net ([195.14.162.78]:12605 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S1751136AbVKNOeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 09:34:14 -0500
Date: Mon, 14 Nov 2005 16:32:48 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051114143248.GA3859@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4378980C.7060901@ens-lyon.fr>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

the same problem is present with 2.6.14 + ipw2200 1.0.8/ieee80211 1.1.6
too. I didn't report problem as I am using madwifi drivers (which
taints the kernel) and thought it was related to madwifi CVS (latest)
and the newest ipw2200 drivers.

All crashes are happening right after messages are print:

ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40

EIP always is cache_alloc_refill() function. Full messages are available
here: http://www.gemtek.lt/~zilvinas/ipw2200-syslog.gz

Zilvinas.


On Mon, Nov 14, 2005 at 02:58:36PM +0100, Alexandre Buisse wrote:
> Hi Linus,
> 
> I experienced a hard crash (no input devices answering at all) yesterday
> while playing a movie from a CD, but with nothing showing up in
> /var/log/messages.
> A few minutes ago, however, I had a nice oops from ipw2200 (I think), a
> few minutes after booting (I had already associated and had a steady
> connection). It then began crashing methodically all of my applications,
> each time producing a oops...
> 
> 
> Nov 14 14:20:09 ubik [  783.604398] ipw2200: Firmware error detected. 
> Restarting.
> Nov 14 14:20:09 ubik [  783.604919] ipw2200: Sysfs 'error' log captured.
> Nov 14 14:20:11 ubik [  785.171844] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:11 ubik [  785.171852]  printing eip:
> Nov 14 14:20:11 ubik [  785.171853] c014cd02
> Nov 14 14:20:11 ubik [  785.171855] *pde = 00000000
> Nov 14 14:20:11 ubik [  785.171858] Oops: 0002 [#1]
> Nov 14 14:20:11 ubik [  785.171860] PREEMPT
> Nov 14 14:20:11 ubik [  785.171863] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:11 ubik [  785.171874] CPU:    0
> Nov 14 14:20:11 ubik [  785.171875] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:11 ubik [  785.171876] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:11 ubik [  785.171886] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:11 ubik [  785.171889] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:11 ubik [  785.171892] esi: 00000032   edi: c14ddb00   ebp:
> dc9d7d60   esp: dc9d7d38
> Nov 14 14:20:11 ubik [  785.171895] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:11 ubik [  785.171898] Process updatedb (pid: 4939,
> threadinfo=dc9d6000 task=df7ad5e0)
> Nov 14 14:20:11 ubik [  785.171900] Stack: c017fe03 dc9d7d78 c017fed1
> c14deb00 c14d9000 cca7201c 0000003b 00000282
> Nov 14 14:20:11 ubik [  785.171907]        c14d7ac0 d9516ee8 dc9d7d78
> c014d15d c14d7ac0 000000d0 fffffff4 ce4f0838
> Nov 14 14:20:11 ubik [  785.171913]        dc9d7d94 c017f71f c14d7ac0
> 000000d0 fffffff4 ce4f0838 d9516ee8 dc9d7db8
> Nov 14 14:20:11 ubik [  785.171920] Call Trace:
> Nov 14 14:20:11 ubik [  785.171922]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:11 ubik [  785.171927]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:11 ubik [  785.171931]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:11 ubik [  785.171935]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:11 ubik [  785.171941]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:11 ubik [  785.171944]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:11 ubik [  785.171948]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:11 ubik [  785.171952]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:11 ubik [  785.171957]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:11 ubik [  785.171961]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:11 ubik [  785.171965]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:11 ubik [  785.171968]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:11 ubik [  785.171972]  [<c0175dd1>] __user_walk+0x31/0x50
> Nov 14 14:20:11 ubik [  785.171976]  [<c016f6eb>] vfs_lstat+0x1b/0x50
> Nov 14 14:20:11 ubik [  785.171979]  [<c016fd69>] sys_lstat64+0x19/0x40
> Nov 14 14:20:11 ubik [  785.171983]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:11 ubik [  785.171986] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:11 ubik [  785.172014]  <6>note: updatedb[4939] exited with
> preempt_count 1
> Nov 14 14:20:11 ubik [  785.305665] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:11 ubik [  785.305674]  printing eip:
> Nov 14 14:20:11 ubik [  785.305676] c014cd02
> Nov 14 14:20:11 ubik [  785.305677] *pde = 00000000
> Nov 14 14:20:11 ubik [  785.305681] Oops: 0002 [#2]
> Nov 14 14:20:11 ubik [  785.305682] PREEMPT
> Nov 14 14:20:11 ubik [  785.305685] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:11 ubik [  785.305695] CPU:    0
> Nov 14 14:20:11 ubik [  785.305696] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:11 ubik [  785.305698] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:11 ubik [  785.305705] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:11 ubik [  785.305709] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:11 ubik [  785.305712] esi: 0000003c   edi: c14ddb00   ebp:
> dacbfd60   esp: dacbfd38
> Nov 14 14:20:11 ubik [  785.305715] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:11 ubik [  785.305717] Process run-crons (pid: 4914,
> threadinfo=dacbe000 task=de847520)
> Nov 14 14:20:11 ubik [  785.305720] Stack: c017fe03 dacbfd78 c017fed1
> c14deb00 c14d9000 00000000 0003aca1 00000282
> Nov 14 14:20:11 ubik [  785.305726]        c14d7ac0 dfcd6c40 dacbfd78
> c014d15d c14d7ac0 000000d0 fffffff4 df88e6b0
> Nov 14 14:20:11 ubik [  785.305733]        dacbfd94 c017f71f c14d7ac0
> 000000d0 fffffff4 df88e6b0 dfcd6c40 dacbfdb8
> Nov 14 14:20:11 ubik [  785.305740] Call Trace:
> Nov 14 14:20:11 ubik [  785.305742]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:11 ubik [  785.305747]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:11 ubik [  785.305751]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:11 ubik [  785.305754]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:11 ubik [  785.305760]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:11 ubik [  785.305763]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:11 ubik [  785.305767]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:11 ubik [  785.305771]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:11 ubik [  785.305776]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:11 ubik [  785.305779]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:11 ubik [  785.305783]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:11 ubik [  785.305787]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:11 ubik [  785.305791]  [<c0175dd1>] __user_walk+0x31/0x50
> Nov 14 14:20:11 ubik [  785.305794]  [<c016f68e>] vfs_stat+0x1e/0x60
> Nov 14 14:20:11 ubik [  785.305798]  [<c016fd29>] sys_stat64+0x19/0x40
> Nov 14 14:20:11 ubik [  785.305801]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:11 ubik [  785.305805] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:11 ubik [  785.305833]  <6>note: run-crons[4914] exited
> with preempt_count 1
> Nov 14 14:20:11 ubik [  785.367684] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:11 ubik [  785.367690]  printing eip:
> Nov 14 14:20:11 ubik [  785.367692] c014cd02
> Nov 14 14:20:11 ubik [  785.367693] *pde = 00000000
> Nov 14 14:20:11 ubik [  785.367695] Oops: 0002 [#3]
> Nov 14 14:20:11 ubik [  785.367697] PREEMPT
> Nov 14 14:20:11 ubik [  785.367698] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:11 ubik [  785.367709] CPU:    0
> Nov 14 14:20:11 ubik [  785.367710] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:11 ubik [  785.367711] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:11 ubik [  785.367717] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:11 ubik [  785.367720] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:11 ubik [  785.367724] esi: 0000003c   edi: c14ddb00   ebp:
> dc9d5d18   esp: dc9d5cf0
> Nov 14 14:20:11 ubik [  785.367727] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:11 ubik [  785.367729] Process qmail-inject (pid: 6098,
> threadinfo=dc9d4000 task=def5da50)
> Nov 14 14:20:11 ubik [  785.367732] Stack: 00000000 dc9d5d30 c017fed1
> c14deb00 c14d9000 00000000 13706655 00000282
> Nov 14 14:20:11 ubik [  785.367738]        c14d7ac0 dae6bb30 dc9d5d30
> c014d15d c14d7ac0 000000d0 fffffff4 dae93090
> Nov 14 14:20:11 ubik [  785.367745]        dc9d5d4c c017f71f c14d7ac0
> 000000d0 fffffff4 dae93090 dae6bb30 dc9d5d70
> Nov 14 14:20:11 ubik [  785.367751] Call Trace:
> Nov 14 14:20:11 ubik [  785.367753]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:11 ubik [  785.367758]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:11 ubik [  785.367762]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:11 ubik [  785.367765]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:11 ubik [  785.367769]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:11 ubik [  785.367773]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:11 ubik [  785.367777]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:11 ubik [  785.367780]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:11 ubik [  785.367784]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:11 ubik [  785.367788]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:11 ubik [  785.367792]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:11 ubik [  785.367796]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:11 ubik [  785.367799]  [<c0175ae4>]
> __path_lookup_intent_open+0x44/0x90
> Nov 14 14:20:11 ubik [  785.367803]  [<c0175b5c>] path_lookup_open+0x2c/0x30
> Nov 14 14:20:11 ubik [  785.367807]  [<c017625c>] open_namei+0x6c/0x650
> Nov 14 14:20:11 ubik [  785.367811]  [<c0163aa5>] filp_open+0x35/0x60
> Nov 14 14:20:11 ubik [  785.367815]  [<c0163e7e>] do_sys_open+0x4e/0xe0
> Nov 14 14:20:11 ubik [  785.367818]  [<c0163f2f>] sys_open+0x1f/0x30
> Nov 14 14:20:11 ubik [  785.367822]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:11 ubik [  785.367825] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:11 ubik [  785.367853]  <6>note: qmail-inject[6098] exited
> with preempt_count 1
> Nov 14 14:20:11 ubik [  785.368813] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:11 ubik [  785.368817]  printing eip:
> Nov 14 14:20:11 ubik [  785.368818] c014cd02
> Nov 14 14:20:11 ubik [  785.368820] *pde = 00000000
> Nov 14 14:20:11 ubik [  785.368822] Oops: 0002 [#4]
> Nov 14 14:20:11 ubik [  785.368823] PREEMPT
> Nov 14 14:20:11 ubik [  785.368825] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:11 ubik [  785.368835] CPU:    0
> Nov 14 14:20:11 ubik [  785.368836] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:11 ubik [  785.368837] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:11 ubik [  785.368841] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:11 ubik [  785.368844] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:11 ubik [  785.368848] esi: 0000003c   edi: c14ddb00   ebp:
> dca19ed0   esp: dca19ea8
> Nov 14 14:20:11 ubik [  785.368850] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:11 ubik [  785.368853] Process cron (pid: 4912,
> threadinfo=dca18000 task=def1ba10)
> Nov 14 14:20:11 ubik [  785.368855] Stack: 00000000 0000000a ffffffff
> c14deb00 c14d9000 0000000a 00000000 00000286
> Nov 14 14:20:11 ubik [  785.368861]        c14d7ac0 c37bf6a4 dca19ee8
> c014d15d c14d7ac0 000000d0 dca19f1c dcbe4980
> Nov 14 14:20:11 ubik [  785.368868]        dca19f04 c017f71f c14d7ac0
> 000000d0 dca19f1c dcbe4980 c37bf6a4 dca19f54
> Nov 14 14:20:11 ubik [  785.368875] Call Trace:
> Nov 14 14:20:11 ubik [  785.368876]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:11 ubik [  785.368880]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:11 ubik [  785.368884]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:11 ubik [  785.368888]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:11 ubik [  785.368892]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:11 ubik [  785.368895]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:11 ubik [  785.368899]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:11 ubik [  785.368903]  [<c042ab7f>] sock_map_fd+0x6f/0x130
> Nov 14 14:20:11 ubik [  785.368908]  [<c042be66>] sys_socket+0x36/0x60
> Nov 14 14:20:11 ubik [  785.368912]  [<c042cca9>] sys_socketcall+0x99/0x290
> Nov 14 14:20:11 ubik [  785.368916]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:11 ubik [  785.368919] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:11 ubik [  785.368947]  <6>note: cron[4912] exited with
> preempt_count 1
> Nov 14 14:20:37 ubik [  810.937331] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:37 ubik [  810.937338]  printing eip:
> Nov 14 14:20:37 ubik [  810.937340] c014cd02
> Nov 14 14:20:37 ubik [  810.937342] *pde = 00000000
> Nov 14 14:20:37 ubik [  810.937344] Oops: 0002 [#5]
> Nov 14 14:20:37 ubik [  810.937346] PREEMPT
> Nov 14 14:20:37 ubik [  810.937348] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:37 ubik [  810.937359] CPU:    0
> Nov 14 14:20:37 ubik [  810.937360] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:37 ubik [  810.937361] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:37 ubik [  810.937370] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:37 ubik [  810.937373] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:37 ubik [  810.937376] esi: 0000003c   edi: c14ddb00   ebp:
> dec13d18   esp: dec13cf0
> Nov 14 14:20:37 ubik [  810.937379] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:37 ubik [  810.937382] Process cpufreqd (pid: 3554,
> threadinfo=dec12000 task=def5d070)
> Nov 14 14:20:37 ubik [  810.937384] Stack: c018035e dec13d30 c017fed1
> c14deb00 c14d9000 dec13d2c 00b118fa 00000282
> Nov 14 14:20:37 ubik [  810.937391]        c14d7ac0 db3396f0 dec13d30
> c014d15d c14d7ac0 000000d0 fffffff4 de95458c
> Nov 14 14:20:37 ubik [  810.937397]        dec13d4c c017f71f c14d7ac0
> 000000d0 fffffff4 de95458c db3396f0 dec13d70
> Nov 14 14:20:37 ubik [  810.937404] Call Trace:
> Nov 14 14:20:37 ubik [  810.937406]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:37 ubik [  810.937411]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:37 ubik [  810.937415]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:37 ubik [  810.937419]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:37 ubik [  810.937424]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:37 ubik [  810.937428]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:37 ubik [  810.937432]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:37 ubik [  810.937436]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:37 ubik [  810.937440]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:37 ubik [  810.937444]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:37 ubik [  810.937448]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:37 ubik [  810.937452]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:37 ubik [  810.937455]  [<c0175ae4>]
> __path_lookup_intent_open+0x44/0x90
> Nov 14 14:20:37 ubik [  810.937460]  [<c0175b5c>] path_lookup_open+0x2c/0x30
> Nov 14 14:20:37 ubik [  810.937463]  [<c017625c>] open_namei+0x6c/0x650
> Nov 14 14:20:37 ubik [  810.937467]  [<c0163aa5>] filp_open+0x35/0x60
> Nov 14 14:20:37 ubik [  810.937471]  [<c0163e7e>] do_sys_open+0x4e/0xe0
> Nov 14 14:20:37 ubik [  810.937474]  [<c0163f2f>] sys_open+0x1f/0x30
> Nov 14 14:20:37 ubik [  810.937478]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:37 ubik [  810.937481] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:37 ubik [  810.937509]  <6>note: cpufreqd[3554] exited with
> preempt_count 1
> Nov 14 14:20:41 ubik [  815.122079] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:41 ubik [  815.122087]  printing eip:
> Nov 14 14:20:41 ubik [  815.122089] c014cd02
> Nov 14 14:20:41 ubik [  815.122091] *pde = 00000000
> Nov 14 14:20:41 ubik [  815.122094] Oops: 0002 [#6]
> Nov 14 14:20:41 ubik [  815.122095] PREEMPT
> Nov 14 14:20:41 ubik [  815.122098] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:41 ubik [  815.122109] CPU:    0
> Nov 14 14:20:41 ubik [  815.122109] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:41 ubik [  815.122111] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:41 ubik [  815.122120] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:41 ubik [  815.122123] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:41 ubik [  815.122126] esi: 0000003c   edi: c14ddb00   ebp:
> dec13d18   esp: dec13cf0
> Nov 14 14:20:41 ubik [  815.122129] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:41 ubik [  815.122132] Process urxvtc (pid: 6106,
> threadinfo=dec12000 task=c720f5a0)
> Nov 14 14:20:41 ubik [  815.122134] Stack: 00000001 dec13d30 c017fed1
> c14deb00 c14d9000 c06952f4 041aa579 00000282
> Nov 14 14:20:41 ubik [  815.122141]        c14d7ac0 df44acc8 dec13d30
> c014d15d c14d7ac0 000000d0 fffffff4 dec92e58
> Nov 14 14:20:41 ubik [  815.122147]        dec13d4c c017f71f c14d7ac0
> 000000d0 fffffff4 dec92e58 df44acc8 dec13d70
> Nov 14 14:20:41 ubik [  815.122154] Call Trace:
> Nov 14 14:20:41 ubik [  815.122156]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:41 ubik [  815.122162]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:41 ubik [  815.122166]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:41 ubik [  815.122169]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:41 ubik [  815.122174]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:41 ubik [  815.122178]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:41 ubik [  815.122182]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:41 ubik [  815.122187]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:41 ubik [  815.122192]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:41 ubik [  815.122195]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:41 ubik [  815.122199]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:41 ubik [  815.122203]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:41 ubik [  815.122206]  [<c0175ae4>]
> __path_lookup_intent_open+0x44/0x90
> Nov 14 14:20:41 ubik [  815.122211]  [<c0175b5c>] path_lookup_open+0x2c/0x30
> Nov 14 14:20:41 ubik [  815.122214]  [<c017625c>] open_namei+0x6c/0x650
> Nov 14 14:20:41 ubik [  815.122218]  [<c0163aa5>] filp_open+0x35/0x60
> Nov 14 14:20:41 ubik [  815.122222]  [<c0163e7e>] do_sys_open+0x4e/0xe0
> Nov 14 14:20:41 ubik [  815.122226]  [<c0163f2f>] sys_open+0x1f/0x30
> Nov 14 14:20:41 ubik [  815.122229]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:41 ubik [  815.122232] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:41 ubik [  815.122260]  <6>note: urxvtc[6106] exited with
> preempt_count 1
> Nov 14 14:20:41 ubik [  815.122392] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:41 ubik [  815.122395]  printing eip:
> Nov 14 14:20:41 ubik [  815.122397] c014cd02
> Nov 14 14:20:41 ubik [  815.122398] *pde = 00000000
> Nov 14 14:20:41 ubik [  815.122400] Oops: 0002 [#7]
> Nov 14 14:20:41 ubik [  815.122402] PREEMPT
> Nov 14 14:20:41 ubik [  815.122403] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:41 ubik [  815.122413] CPU:    0
> Nov 14 14:20:41 ubik [  815.122414] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:41 ubik [  815.122415] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:41 ubik [  815.122419] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:41 ubik [  815.122422] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:41 ubik [  815.122426] esi: 0000003c   edi: c14ddb00   ebp:
> db327d60   esp: db327d38
> Nov 14 14:20:41 ubik [  815.122428] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:41 ubik [  815.122431] Process zsh (pid: 5125,
> threadinfo=db326000 task=c9c9c520)
> Nov 14 14:20:41 ubik [  815.122433] Stack: db327d58 db327d78 c017fed1
> c14deb00 c14d9000 00000001 01cd253f 00000282
> Nov 14 14:20:41 ubik [  815.122440]        c14d7ac0 df107910 db327d78
> c014d15d c14d7ac0 000000d0 fffffff4 dfb15cd0
> Nov 14 14:20:41 ubik [  815.122446]        db327d94 c017f71f c14d7ac0
> 000000d0 fffffff4 dfb15cd0 df107910 db327db8
> Nov 14 14:20:41 ubik [  815.122453] Call Trace:
> Nov 14 14:20:41 ubik [  815.122454]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:41 ubik [  815.122458]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:41 ubik [  815.122462]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:41 ubik [  815.122466]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:41 ubik [  815.122469]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:41 ubik [  815.122473]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:41 ubik [  815.122477]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:41 ubik [  815.122480]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:41 ubik [  815.122484]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:41 ubik [  815.122487]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:41 ubik [  815.122491]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:41 ubik [  815.122495]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:41 ubik [  815.122499]  [<c0175dd1>] __user_walk+0x31/0x50
> Nov 14 14:20:41 ubik [  815.122502]  [<c016f68e>] vfs_stat+0x1e/0x60
> Nov 14 14:20:41 ubik [  815.122506]  [<c016fd29>] sys_stat64+0x19/0x40
> Nov 14 14:20:41 ubik [  815.122509]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:41 ubik [  815.122513] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:41 ubik [  815.122540]  <6>note: zsh[5125] exited with
> preempt_count 1
> Nov 14 14:20:41 ubik [  815.124579] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:41 ubik [  815.124583]  printing eip:
> Nov 14 14:20:41 ubik [  815.124585] c014cd02
> Nov 14 14:20:41 ubik [  815.124586] *pde = 00000000
> Nov 14 14:20:41 ubik [  815.124588] Oops: 0002 [#8]
> Nov 14 14:20:41 ubik [  815.124589] PREEMPT
> Nov 14 14:20:41 ubik [  815.124591] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:41 ubik [  815.124601] CPU:    0
> Nov 14 14:20:41 ubik [  815.124602] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:41 ubik [  815.124603] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:41 ubik [  815.124608] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:41 ubik [  815.124611] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:41 ubik [  815.124614] esi: 0000003c   edi: c14ddb00   ebp:
> c9d27ed0   esp: c9d27ea8
> Nov 14 14:20:41 ubik [  815.124617] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:41 ubik [  815.124619] Process su (pid: 5115,
> threadinfo=c9d26000 task=ca3275e0)
> Nov 14 14:20:41 ubik [  815.124621] Stack: 00000000 0000000a ffffffff
> c14deb00 c14d9000 0000000a 00000000 00000286
> Nov 14 14:20:41 ubik [  815.124628]        c14d7ac0 c37bf524 c9d27ee8
> c014d15d c14d7ac0 000000d0 c9d27f1c c296e380
> Nov 14 14:20:41 ubik [  815.124634]        c9d27f04 c017f71f c14d7ac0
> 000000d0 c9d27f1c c296e380 c37bf524 c9d27f54
> Nov 14 14:20:41 ubik [  815.124641] Call Trace:
> Nov 14 14:20:41 ubik [  815.124643]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:41 ubik [  815.124647]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:41 ubik [  815.124651]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:41 ubik [  815.124654]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:41 ubik [  815.124658]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:41 ubik [  815.124662]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:41 ubik [  815.124665]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:41 ubik [  815.124669]  [<c042ab7f>] sock_map_fd+0x6f/0x130
> Nov 14 14:20:41 ubik [  815.124674]  [<c042be66>] sys_socket+0x36/0x60
> Nov 14 14:20:41 ubik [  815.124678]  [<c042cca9>] sys_socketcall+0x99/0x290
> Nov 14 14:20:41 ubik [  815.124682]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:41 ubik [  815.124685] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20
> Nov 14 14:20:41 ubik [  815.124713]  <6>note: su[5115] exited with
> preempt_count 1
> 
> 
> Regards,
> Alexandre
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
