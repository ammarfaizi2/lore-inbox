Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbTDAWda>; Tue, 1 Apr 2003 17:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbTDAWda>; Tue, 1 Apr 2003 17:33:30 -0500
Received: from jalon.able.es ([212.97.163.2]:51956 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262905AbTDAWd2>;
	Tue, 1 Apr 2003 17:33:28 -0500
Date: Wed, 2 Apr 2003 00:44:46 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: netfilter/iptables bug ?
Message-ID: <20030401224446.GA4349@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I'm trying to do NAT from a internal eth1 to external eth0 (connected
with a cable modem). Every doc I read says I should do:

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

But I just keep getting:

iptables: Invalid argument

Kernel: 2.4.21-pre6 + -pre5-aa. iptables 1.2.7a.
Modules loaded:

ipt_state               1080   0  (unused)
iptable_mangle          2776   0  (autoclean) (unused)
ipt_MASQUERADE          2296   0  (autoclean)
iptable_nat            22136   0  (autoclean) [ipt_MASQUERADE]
ip_conntrack           26848   2  (autoclean) [ipt_state ipt_MASQUERADE iptable_nat]

Is anybody aware of any obscure bug ? What does fail ?
I have read reports, for example, of this same command working on
RH 7.2 and faling the same way on 7.3 (I use Mandrake 9.1).

Any idea would be appreciated. TIA.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
