Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbTAJJOc>; Fri, 10 Jan 2003 04:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTAJJOc>; Fri, 10 Jan 2003 04:14:32 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:3845 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264617AbTAJJO1>; Fri, 10 Jan 2003 04:14:27 -0500
Message-Id: <200301100916.h0A9Gus15400@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Jim Roland" <jroland@roland.net>, <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd_CPU0 causing severe latency
Date: Fri, 10 Jan 2003 11:16:49 +0200
X-Mailer: KMail [version 1.3.2]
References: <004d01c2b873$44156d80$2002a8c0@jimws>
In-Reply-To: <004d01c2b873$44156d80$2002a8c0@jimws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 08:41, Jim Roland wrote:
> I am running a RH7.2 router with kernel 2.4.18-19.7.x and upgraded
> from 2.4.18-17 in hopes this would fix the problem, but it hasn't.
>
> The problem I am experiencing is that after a while, the system
> begins to lag badly, and running "ps -ax" writes to a SSH console
> like a terminal running at 14.4kbps.  This only seems to have
> occurred after the box started procesing a network load.
>
> The box is a router, with a Supermicro (model=?) motherboard with
> embedded Intel EEpro/100 NICs using the eepro100 module.  This box is
> also serving as an iptables filter for the network as well.  It's
> processing approximately 60Mbps sustained traffic outbound, and about
> 10-15Mbps traffic inbound.

That's not a small figure :)

> The box also lags SEVERLY when I'm trying to use the state matching
> in the kernel (as module), lagging badly when ip_conntrack is loaded.
>
> In contrast, I am running the same OS and kernel versions on another
> box (same modules) and am not having the same problem (it is only
> handling about 5Mbps sustained out, and 1Mbps sustained inbound).
>
> I need HELP!

Profile your box. (We need to know where it spends most of CPU time).
Send profile data to the list.

Also collect interrupt rate info.

You may also look into Intel EEpro/100 driver's interrupt handler code.

Does is lag that bad without iptables?
--
vda
