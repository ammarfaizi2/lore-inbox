Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUEDT2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUEDT2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUEDT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:28:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264484AbUEDT23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:28:29 -0400
Date: Tue, 4 May 2004 12:28:34 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: roland.mas@free.fr, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at usb-ohci.h:464!" and 8139too -- 2.4.25
Message-Id: <20040504122834.674d7e22.zaitcev@redhat.com>
In-Reply-To: <20040504123534.GB9037@logos.cnet>
References: <20040504123534.GB9037@logos.cnet>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Roland Mas <roland.mas@free.fr>
> Date:	Wed, 31 Mar 2004 22:29:32 +0200

> This is my ADSL gateway/firewall.  Old ISA card (module ne), which has
> worked flawlessly for months.  USB modem based on the Eagle chipset by
> Analog Devices Inc. (ADI), driver is not in mainline kernel, but it
> also has worked for months (except when my ISP played silly buggers).

>[...]
>   My problem: after some time (a few hours), I get a kernel panic
> speaking of a "kernel BUG at usb-ohci.h:464!".  The only USB
> peripheral is the ADSL modem.  If I unload 8139too and alias eth0 ne,
> but leave the Realtek NIC plugged in, I get no such panic.

> | >>EIP; c4862f47 <[usb-ohci]dl_reverse_done_list+63/f0>   <=====

It is not my change to usb-ohci, because that one went to 2.4.26.
In fact, I think might actually help! Roland, please try 2.4.26.

Is the Eagle thing open source or binary? If it's open, it might
stand a little review and cleanup on linux-kernel or linux-usb-devel.

-- Pete
