Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUHPWev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUHPWev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUHPWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:33:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18829 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267993AbUHPWcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:32:51 -0400
Date: Mon, 16 Aug 2004 15:32:43 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] blacklist a device in usb-storage
Message-Id: <20040816153243.7e050372@lembas.zaitcev.lan>
In-Reply-To: <4120D8B1.6040000@ttnet.net.tr>
References: <mailman.1092508141.32379.linux-kernel2news@redhat.com>
	<20040815235204.0e9ec874@lembas.zaitcev.lan>
	<412066BC.9040503@ttnet.net.tr>
	<20040816080751.733c188d@lembas.zaitcev.lan>
	<4120D8B1.6040000@ttnet.net.tr>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 18:54:25 +0300
"O.Sezer" <sezeroz@ttnet.net.tr> wrote:

> EIP: 0010: [<e0d24da0>]  Not tainted

> Call Trace: [<e0a3b9cf>]  [<e0a3bde4>]  [<e0207ee9>]
>          [<e0a3be87>]   [<c010a848>]  [<c010aa33>]
>          [<e0ae4385>]   [<c0107150>]   [<c0105000>]
>          [<c01071f4>]

>  >>EIP; e0d24da0 <[sr_mod]sr_registered+22deec/22e1ac>   <=====

> Trace; e0a3b9cf <[usb-uhci]process_interrupt+21f/260>
> Trace; e0a3bde4 <[usb-uhci]process_urb+254/260>
> Trace; e0207ee9 <_end+1fe721a5/2064e31c>
> Trace; e0a3be87 <[usb-uhci]uhci_interrupt+97/170>
> Trace; c010a848 <handle_IRQ_event+48/80>
> Trace; c010aa33 <do_IRQ+83/f0>
> Trace; c0107150 <default_idle+0/40>
> Trace; c01071f4 <cpu_idle+34/40>

Hmm. This looks fishy, because sr_registered is not a function.

Does the same happen after "echo /bin/true > /proc/sys/kernel/hotplug"?
Maybe your hotplug setup yanks a module. I heard some crazy distro
did that on unplug.

-- Pete
