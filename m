Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132402AbRAMVPm>; Sat, 13 Jan 2001 16:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRAMVPZ>; Sat, 13 Jan 2001 16:15:25 -0500
Received: from main.braxis.co.uk ([212.160.232.26]:45830 "EHLO
	main.braxis.co.uk") by vger.kernel.org with ESMTP
	id <S132402AbRAMVPN>; Sat, 13 Jan 2001 16:15:13 -0500
Date: Sat, 13 Jan 2001 22:11:42 +0100
From: Krzysztof Rusocki <lkml@braxis.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 (w/XFS) & reset_xmit_timer
Message-ID: <20010113221142.A3913@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Since 2.4.0 (from XFS CVS source tree) i get such things from kernel:

Jan 13 20:55:48 main kernel: reset_xmit_timer sk=c299b9a0 1 when=0x6061, caller=c0218f88 
Jan 13 20:58:09 main kernel: reset_xmit_timer sk=c49aa040 1 when=0x594b, caller=c0218f88 
Jan 13 21:01:30 main kernel: reset_xmit_timer sk=c0a25040 1 when=0x2f24, caller=c0218f88 
Jan 13 21:22:33 main kernel: reset_xmit_timer sk=c6ce99a0 1 when=0x337a, caller=c0218f88 
Jan 13 21:32:15 main kernel: reset_xmit_timer sk=c2fb5680 1 when=0x58ef, caller=c0218f88 
Jan 13 21:34:49 main kernel: reset_xmit_timer sk=c46bccc0 1 when=0x2fcf, caller=c0218f88 
Jan 13 21:34:52 main kernel: reset_xmit_timer sk=c2a949a0 1 when=0x3724, caller=c0218f88 
Jan 13 21:36:42 main kernel: reset_xmit_timer sk=c49aa040 1 when=0x8fbf, caller=c0218f88 
Jan 13 21:41:42 main kernel: reset_xmit_timer sk=c49aa040 1 when=0x4c4e, caller=c0218f88 
Jan 13 21:45:51 main kernel: reset_xmit_timer sk=c398f360 1 when=0x552b, caller=c0218f88 
Jan 13 21:50:38 main kernel: reset_xmit_timer sk=c7c979a0 1 when=0x3caf, caller=c0218f88 
Jan 13 21:50:38 main kernel: reset_xmit_timer sk=c7c979a0 1 when=0x38d3, caller=c0218f88 
Jan 13 21:50:38 main kernel: reset_xmit_timer sk=c7c979a0 1 when=0x3432, caller=c0218f88 

On 2.4.0-test13-pre3 (patched with XFS patch from SGI) there was _NO_ such
things... I ain't kernel developer, so i have no idea of possible cause...

My 2.4.0-t13-pre3 and 2.4.0 kernel configs does _NOT_ practically differ.

I use DM9102 ethernet driver together with QoS (CBQ & TBF queues and U32
classifier).

I didn't find this problem related stuff in LKML archives, so i decided to
write this down here...

- Krzysztof

PS
sorry for my english
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
