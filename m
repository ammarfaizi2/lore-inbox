Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTFZX1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFZX1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 19:27:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41437 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262367AbTFZX1T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 19:27:19 -0400
Date: Thu, 26 Jun 2003 16:41:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Diego Calleja =?ISO-8859-1?B?R2FyY+1h?= <diegocg@teleline.es>
Cc: dgp85@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: PPP Modem connection impossible with 2.5.73-bk2
Message-Id: <20030626164116.1bfbad1e.shemminger@osdl.org>
In-Reply-To: <20030626195238.673bcffd.diegocg@teleline.es>
References: <1056567978.931.8.camel@laurelin>
	<20030626195238.673bcffd.diegocg@teleline.es>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003 19:52:38 +0200
Diego Calleja García <diegocg@teleline.es> wrote:

> On 25 Jun 2003 21:06:18 +0200
> Flameeyes <dgp85@users.sourceforge.net> wrote:
> 
> > Hi,
> > After the upgrade from 2.5.73-bk1 to bk2 the pppd daemon is killed, so
> > the ppp connection is impossible.
> > After the reverse of the patch I can connect.
> > I also applied the bk2-bk3 patch (without the bk2), and I have no
> > problems.
> > So the problem is in bk2.
> 
> 
> I can confirm it.
> Jun 25 00:11:09 estel chat[13737]:  -- got it 
> Jun 25 00:11:09 estel chat[13737]: send (\d)
> Jun 25 00:11:10 estel pppd[13734]: Serial connection established.
> Jun 25 00:11:10 estel pppd[13734]: using channel 8
> Jun 25 00:11:10 estel pppd[13734]: Using interface ppp0
> Jun 25 00:11:10 estel pppd[13734]: Connect: ppp0 <--> /dev/ttyS1
> Jun 25 00:11:11 estel pppd[13734]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magi
> c 0x54b41996> <pcomp> <accomp>]
> Jun 25 00:11:11 estel pppd[13734]: rcvd [LCP ConfReq id=0x1 <mru 1514> <asyncmap
>  0x0> <auth chap MD5> <magic 0xf1833c0e> <mrru 1514> <endpoint [null]>]
> Jun 25 00:11:11 estel pppd[13734]: sent [LCP ConfRej id=0x1 <mrru 1514>]
> Jun 25 00:11:11 estel pppd[13734]: rcvd [LCP ConfRej id=0x1 <pcomp>]
> Jun 25 00:11:11 estel pppd[13734]: sent [LCP ConfReq id=0x2 <asyncmap 0x0> <magi
> c 0x54b41996> <accomp>]
> Jun 25 00:11:11 estel pppd[13734]: Modem hangup
> Jun 25 00:11:11 estel pppd[13734]: Connection terminated.
> Jun 25 00:11:12 estel pppd[13734]: tcsetattr: Invalid argument
> Jun 25 00:11:12 estel pppd[13734]: Exit.
> 
> 
> Plain 2.5.73 works.

What is your ppp configuration, anything special? 
Is serial line fat or slow? Is this on SMP or UP system?

I can't reproduce this over a null modem cable so trying to see what could
be different.
