Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSLPNUk>; Mon, 16 Dec 2002 08:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLPNUk>; Mon, 16 Dec 2002 08:20:40 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:8576 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S266708AbSLPNUj>;
	Mon, 16 Dec 2002 08:20:39 -0500
Subject: NFS crash with 2.4.19
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Toeysvjzj3O/XE2+2VGa"
Organization: 
Message-Id: <1040045366.861.9.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 16 Dec 2002 14:29:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Toeysvjzj3O/XE2+2VGa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I got this error on my server tonight. It is running 2.4.19, and have
done so happily without reboot a couple of months. Last night I
nfs-mounted a disk from another box on the server. This other box
crashed during the night (probably some hardware fault), but then I got
the attached error message in the log. The server still worked fine for
remote services, but I got no response at all on the console. 

Anyone have any idea why? I just took a controlled reboot to get rid of
it as fast as possible, because I'm not around the server more for a
couple of days. But what could have caused this?

Best regards,
Stian Jordet

--=-Toeysvjzj3O/XE2+2VGa
Content-Disposition: attachment; filename=crash.txt
Content-Type: text/plain; name=crash.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dec 16 03:51:12 dodge kernel: Unable to handle kernel NULL pointer dereference at virtual address 000005dc
Dec 16 03:51:12 dodge kernel:  printing eip:
Dec 16 03:51:12 dodge kernel: 000005dc
Dec 16 03:51:12 dodge kernel: *pde = 00000000
Dec 16 03:51:12 dodge kernel: Oops: 0000
Dec 16 03:51:12 dodge kernel: CPU:    0
Dec 16 03:51:12 dodge kernel: EIP:    0010:[cleanup+1212/-1072693536]    Not tainted
Dec 16 03:51:12 dodge kernel: EFLAGS: 00010296
Dec 16 03:51:12 dodge kernel: eax: c4ba53a0   ebx: cb311a60   ecx: c74f19a0   edx: 0000069c
Dec 16 03:51:12 dodge kernel: esi: c33f00e0   edi: 00000040   ebp: 00000000   esp: c2e37bb4
Dec 16 03:51:12 dodge kernel: ds: 0018   es: 0018   ss: 0018
Dec 16 03:51:12 dodge kernel: Process wget (pid: 19813, stackpage=c2e37000)
Dec 16 03:51:12 dodge kernel: Stack: c8ba2024 c01f1250 cb311a60 000005fb 00000000 00000040 c2e37c34 c8ba2024
Dec 16 03:51:12 dodge kernel:        c02038a3 cb311a60 000005fb 00000040 c2e37c34 c021b568 cb311a60 c2e37cd0
Dec 16 03:51:12 dodge kernel:        00002098 00000000 000005c8 00000040 000005c8 c2e37c34 c8ba2010 00000040
Dec 16 03:51:12 dodge kernel: Call Trace:    [sock_alloc_send_skb+28/36] [ip_build_xmit_slow+419/1216] [udp_getfrag+0/196] [ip_build_xmit+78/840] [udp_getfrag+0/196]
Dec 16 03:51:12 dodge kernel:   [qdisc_restart+19/200] [udp_sendmsg+849/972] [udp_getfrag+0/196] [inet_sendmsg+58/64] [sock_sendmsg+105/136] [do_xprt_transmit+334/988]
Dec 16 03:51:12 dodge kernel:   [nf_hook_slow+238/324] [ip_output+278/284] [ip_finish_output2+0/208] [ip_queue_xmit2+286/512] [nfs_xdr_writeargs+0/216] [rpcauth_marshcred+85/92]
Dec 16 03:51:12 dodge kernel:   [xprt_transmit+158/168] [call_transmit+62/100] [__rpc_execute+168/700] [nfs_write_rpcsetup+113/332] [rpc_call_setup+50/112] [rpc_execute+87/112]
Dec 16 03:51:12 dodge kernel:   [nfs_flush_one+461/728] [nfs_flush_list+88/368] [nfs_flush_file+86/116] [nfs_strategy+66/72] [nfs_updatepage+388/512] [nfs_commit_write+28/36]
Dec 16 03:51:12 dodge kernel:   [generic_file_write+1251/1800] [nfs_file_write+159/172] [sys_write+150/240] [system_call+51/56]
Dec 16 03:51:12 dodge kernel:
Dec 16 03:51:12 dodge kernel: Code:  Bad EIP value.


--=-Toeysvjzj3O/XE2+2VGa--

