Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271489AbSISPoN>; Thu, 19 Sep 2002 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271545AbSISPoM>; Thu, 19 Sep 2002 11:44:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:38134
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S271489AbSISPoM>; Thu, 19 Sep 2002 11:44:12 -0400
Subject: Re: Info: NAPI performance at "low" loads
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca, akpm@digeo.com,
       manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <m18z1ykoms.fsf@frodo.biederman.org>
References: <1032381789.20498.151.camel@irongate.swansea.linux.org.uk>
	<20020918.134630.127509858.davem@redhat.com>
	<1032383727.20463.155.camel@irongate.swansea.linux.org.uk>
	<20020918.142250.130847722.davem@redhat.com> 
	<m18z1ykoms.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 16:53:02 +0100
Message-Id: <1032450782.27721.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 16:03, Eric W. Biederman wrote:
> If I do an inb to a PCI-X device running at 133Mhz it should come back
> much faster than an inb from my serial port on the ISA port.  What
> is the reason for the fixed minimum timing?

As far as I can tell the minimum time for the inb/outb is simply the
time it takes the bus to respond. The only difference there is that for
writel rather than outl you won't wait for the write to complete on the
PCI bus just dump it into the fifo if its empty

