Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUIOUnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUIOUnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUIOUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:41:44 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:13830 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S267382AbUIOUjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:39:46 -0400
Date: Wed, 15 Sep 2004 13:16:36 -0700
From: "David Schwartz" <davids@webmaster.com>
To: "David Stevens" <dlstevens@us.ibm.com>, "Netdev" <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com, "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <WorldClient-F200409151316.AA16360002@webmaster.com>
X-Mailer: WorldClient 7.1.0
In-Reply-To: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
References: <4148991B.9050200@pobox.com> <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 15 Sep 2004 13:16:38 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 127.0.0.1
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 15 Sep 2004 13:16:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Stevens wrote:

> I've never understood why people are so interested in off-loading
> networking. Isn't that just a multi-processor system where you can't
> use any of the network processor cycles for anything else? And, of
> course, to be cheap, the network processor will be slower, and much
> harder to debug and update software.

The issues of debugging the network processor software and maintaining it is 
certainly a legitimate one. However, nothing stops you from using the extra 
network processor cycles for other purposes.

> If the PCI bus is too slow, or MTU's too small, wouldn't
> it be better to fix those directly and use a fast host processor that
> can
> also do other things when not needed for networking? And why have
> memory on a NIC that can't be used by other things?

This isn't an either-or. Processors are cheap. Memory is cheap.
 
> Why don't we off-load filesystems to disks instead?  Or a graphics
> card that implements X ? :-) I'd rather have shared system resources--
> more flexible. :-)

It's not one or the other. If, for example, your network card, graphics 
card, and hard drive controller all use a common instruction set and are all 
interconnected by a fast bus, code can be fairly mobile and run wherever 
it's the most efficient. Nothing stops the OS from offloading internal tasks 
to these processors as well.

The only real stumbling blocks have been cost/volume considerations and the 
fact that the central processor(s) can be so fast, and the I/O so slow in 
comparison, that there's not much to gain.

DS


