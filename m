Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTDDUjX (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbTDDUjX (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:39:23 -0500
Received: from mail.hot.ee ([194.126.101.94]:37805 "EHLO hot.ee")
	by vger.kernel.org with ESMTP id S261223AbTDDUjV (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:39:21 -0500
From: Nestor Aaro <lkernel@hot.ee>
Reply-To: lkernel@hot.ee
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with PPPoE on 2.5.65-66.bk9
Date: Fri, 4 Apr 2003 23:50:49 +0300
User-Agent: KMail/1.5
References: <200304042007.01159.lkernel@hot.ee> <200304042102.36630.baldrick@wanadoo.fr> <200304042320.24870.lkernel@hot.ee>
In-Reply-To: <200304042320.24870.lkernel@hot.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304042350.49494.lkernel@hot.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 April 2003 23:20, Nestor Aaro wrote:
> On Friday 04 April 2003 22:02, you wrote:
> > > # CONFIG_PPPOE is not set
> >
> > Looks like you forgot to turn on pppoe support in the kernel.
>
> rp-pppoe don't need kernel support. Btw it was working fine in 2.5.42
> kernel.
>
> Ok. I try it:
> All instructions in readme is followed and here is result:
> /var/log/kernelmessages
> Apr  4 22:55:28 localhost kernel: Module ppp_async cannot be unloaded due
> to unsafe usage in include/linux/module.h:428
> Apr  4 22:57:18 localhost kernel: Module pppoe cannot be unloaded due to
> unsafe usage in include/linux/module.h:428
>
> /var/log/messages
> Apr  4 22:55:28 localhost kernel: eth0: Setting 3c5x9/3c5x9B half-duplex
> mode if_port: 0, sw_info: 1321
> Apr  4 22:55:28 localhost kernel: CSLIP: code copyright 1989 Regents of the
> University of California
> Apr  4 22:55:28 localhost kernel: PPP generic driver version 2.4.2
> Apr  4 22:55:28 localhost pppd[154]: pppd 2.4.1 started by root, uid 0
> Apr  4 22:55:28 localhost kernel: Module ppp_async cannot be unloaded due
> to unsafe usage in include/linux/module.h:428
> Apr  4 22:55:28 localhost pppd[154]: Using interface ppp0
> Apr  4 22:55:28 localhost pppd[154]: Connect: ppp0 <--> /dev/pts/0
> Apr  4 22:55:59 localhost pppd[154]: LCP: timeout sending Config-Requests
> Apr  4 22:55:59 localhost pppd[154]: Connection terminated.
> Apr  4 22:56:03 localhost pppoe[155]: Timeout waiting for PADO packets
> Apr  4 22:56:03 localhost pppd[154]: Exit.
> Apr  4 22:57:18 localhost kernel: Module pppoe cannot be unloaded due to
> unsafe usage in include/linux/module.h:428
> Apr  4 22:59:51 localhost pppd[1683]: /etc/ppp/plugins/rp-pppoe.so:
> undefined symbol: generic_establish_ppp
> Apr  4 22:59:51 localhost pppd[1683]: Couldn't load plugin
> /etc/ppp/plugins/rp-pppoe.so
> Apr  4 22:59:51 localhost adsl-connect: ADSL connection lost; attempting
> re-connection.
> Apr  4 22:59:56 localhost pppd[1704]: /etc/ppp/plugins/rp-pppoe.so:
> undefined symbol: generic_establish_ppp
> Apr  4 22:59:56 localhost pppd[1704]: Couldn't load plugin
> /etc/ppp/plugins/rp-pppoe.so
> Apr  4 22:59:56 localhost adsl-connect: ADSL connection lost; attempting
> re-connection.
> Apr  4 23:00:01 localhost pppd[1734]: /etc/ppp/plugins/rp-pppoe.so:
> undefined symbol: generic_establish_ppp
> Apr  4 23:00:01 localhost pppd[1734]: Couldn't load plugin
> /etc/ppp/plugins/rp-pppoe.so
> Apr  4 23:00:01 localhost adsl-connect: ADSL connection lost; attempting
> re-connection.
> Apr  4 23:05:56 localhost pppd[1816]: /etc/ppp/plugins/rp-pppoe.so:
> undefined symbol: generic_establish_ppp
> Apr  4 23:05:57 localhost pppd[1816]: Couldn't load plugin
> /etc/ppp/plugins/rp-pppoe.so
> Apr  4 23:05:57 localhost adsl-connect: ADSL connection lost; attempting
> re-connection.
> Apr  4 23:06:02 localhost pppd[1844]: /etc/ppp/plugins/rp-pppoe.so:
> undefined symbol: generic_establish_ppp
> Apr  4 23:06:02 localhost pppd[1844]: Couldn't load plugin
> /etc/ppp/plugins/rp-pppoe.so
> Apr  4 23:06:02 localhost adsl-connect: ADSL connection lost; attempting
> re-connection.
> Apr  4 23:06:07 localhost pppd[1865]: /etc/ppp/plugins/rp-pppoe.so:
> undefined symbol: generic_establish_ppp
> Apr  4 23:06:07 localhost pppd[1865]: Couldn't load plugin
> /etc/ppp/plugins/rp-pppoe.so
> Apr  4 23:06:07 localhost adsl-connect: ADSL connection lost; attempting
> re-connection.
> ---------------------------------------------------------------------------
>---------- But again, all was working fine, without kernel pppoe module and
> without rp-pppoe plugin in Kernel-2.5.42.
>
> ----------
> Sorry for my bad english! :)

