Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUIWBrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUIWBrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUIWBrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:47:24 -0400
Received: from relay6.ptmail.sapo.pt ([212.55.154.26]:57739 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S268131AbUIWBrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:47:20 -0400
Subject: Re: 2.6.9-rc2-mm2
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
References: <20040922131210.6c08b94c.akpm@osdl.org>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 23 Sep 2004 02:47:21 +0100
Message-Id: <1095904041.4225.11.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried it on my laptop. I have a speedtouch usb adsl modem and
when it connects the computer freezes, around the same time that
messages are printed to the console showing that the ppp compression
modules were loaded.
Sysrq still works, I was able to get this trace form sysrq-p (sorry, no
other machine to dump netconsole output to), process id pppd:

EIP fn_hash_delete
ipv4_doint_and_flush
fib_magic
fib_del_ifaddr
fib_inetaddr
notifier_call_chain
inet_del_ifa
inet_insert_ifa
devinet_ioctl
inet_ioctl
sock_ioctl
sys_ioctl
syscall_call

I know it's a little short on debugging information but it's all I can
do for now
-- 
Nuno Ferreira

