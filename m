Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVHYNjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVHYNjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVHYNjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:39:05 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:1395 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964977AbVHYNjD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:39:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=inuR47igPGB+jIbCppXVAdX6rphl3KkMP7a4IYUNKIKF5jRpzC26HKmGzpn2mcQ/PNWdqHrxRL8t5tpKqF4T5QO8QtKjpmc/qxWbZN6zL6Tn++Cr1fhbZsyXrcrDS+NwRFR3/U/GKtFeZYmiDImHMYJcJf5JeWjCSLSkE+Kh3k4=
Message-ID: <5a4c581d05082506395fa984ae@mail.gmail.com>
Date: Thu, 25 Aug 2005 15:39:02 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: oops in 2.6.13-rc6-git12 in tcp/netfilter routines
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy, and excuse me for crossposting - feel free to zap CC to
 unrelated, if any, mailing lists.

  just gave PeerGuardian a spin on my eDonkey home box and
  said box didn't last half a day before oopsing in netlink/nf/tcp
  related routines (or so it seems to my untrained eye).

K7800, 256MB RAM, uptodate FC3 running 2.6.13-rc6-git12,
 doing nothing but running MetaMachine's eDonkey 1.4.3 QT gui.
PeerGuardian is the 1.5 beta version available from methlabs.org.

Stack is hand-copied from the dead box's console. 

[<c0103714>] die+0xe4/0x170
[<c010381f>] do_trap+0x7f/0xc0
[<c0103b33>] do_invalid_op+0xa3/0xb0
[<c0102faf>] error_code+0x4f/0x54
[<c02eb05b>] kfree_skbmem+0xb/0x20
[<c02eb0cf>] __kfree_skb+0x5f/0xf0
[<c031304a>] tcp_clean_rtx_queue+0x16a/0x470
[<c0313746>] tcp_ack+0xf6/0x360
[<c0315d57>] tcp_rcv_established+0x277/0x7a0
[<c031eba0>] tcp_v4_do_rcv+0xf0/0x110
[<c031f2a0>] tcp_v4_rcv+0x6e0/0x820
[<c0305594>] ip_local_deliver_finish+0x84/0x160
[<c02fbe4a>] nf_reinject+0x13a/0x1c0
[<c033f0d8>] ipq_issue_verdict+0x28/0x40
[<c033f968>] ipq_set_verdict+0x48/0x70
[<c033fa79>] ipq_receive_peer+0x39/0x50
[<c033fc72>] ipq_receive_sk+0x172/0x190
[<c02fffa5>] netlink_data_ready+0x35/0x60
[<c02ff4a4>] netlink_sendskb+0x24/0x60
[<c02ff657>] netlink_unicast+0x127/0x160
[<c02ffcc4>] netlink_sendmsg+0x204/0x2b0
[<c02e6dc0>] sock_sendmsg+0xb0/0xe0
[<c02e83f4>] sys_sendmsg+0x134/0x240
[<c02e88e4>] sys_socketcall+0x224/0x230
[<c0102d3b>] sysenter_past_esp+0x54/0x75
Code: 8b 41 0c 85 c0 75 1b 8b 86 94 00 00 00 e8 9e 37 e5 ff 5b 5e c9
c3 89 d0 e8 43 46 e5 ff 8d 76 00 eb d2 89 f0 e8 f7 fe ff ff eb dc <0f>
0b 54 01 16 d2 36 c0 eb b4 8d 74 26 00 8d bc 27 00 00 00 00
<0>Kernel panic - not syncing: Fatal exception in interrupt

If there's need for further info I'd be happy to provide it. For now
 the box is rebooted into the same kernel and running the same
 PG/eD2k programs, if the issue reproduces I'll follow up on my
 own message.

Thanks in advance, ciao,

--alessandro

 "Not every smile means I'm laughing inside"

    (Wallflowers - "From The Bottom Of My Heart")
