Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbULGCqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbULGCqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 21:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbULGCqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 21:46:45 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:34522 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261739AbULGCqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 21:46:42 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041207002012.GB30674@quickstop.soohrt.org>
References: <20041206224107.GA8529@soohrt.org>
	 <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
	 <20041207002012.GB30674@quickstop.soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102387595.1088.48.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Dec 2004 21:46:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your numbers are very suspect. You may be having other issues in the
box. You should be able to do much higher packet rates even with
iptables compiled in.
Some numbers at:

http://www.suug.ch/sucon/04/slides/pkt_cls.pdf

If all you need is std filtering then consider using tc actions.
I do have a suspicion that your problem has to do with your machine
more than it does with Linux.

cheers,
jamal

On Mon, 2004-12-06 at 19:20, Karsten Desler wrote:
> Bernd Eckenfels <ecki-news2004-05@lina.inka.de> wrote:
> > In article <20041206224107.GA8529@soohrt.org> you wrote:
> > > Removing the iptables rules helps reducing the load a little, but the
> > > majority of time is still spent somewhere else.
> > 
> > In handling Interrupts. Are those equally sidtributed on eth0 and eth1?
> 
> Yes they are.
> 
> Thanks,
>  Karsten
> 
>            CPU0       CPU1       
>   0:  117199776  133677244    IO-APIC-edge  timer
>   1:          0          9    IO-APIC-edge  i8042
>   8:          0          4    IO-APIC-edge  rtc
>   9:          0          0   IO-APIC-level  acpi
> 169:        139  893669684   IO-APIC-level  eth0
> 177:  919803109      30665   IO-APIC-level  eth1
> 209:     414257     413316   IO-APIC-level  libata
> NMI:          0          0 
> LOC:  250918849  250918819 
> ERR:          0
> MIS:          0
> 
> 

