Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTFZRiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFZRiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 13:38:25 -0400
Received: from smtp.terra.es ([213.4.129.129]:60155 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id S262227AbTFZRiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 13:38:24 -0400
Date: Thu, 26 Jun 2003 19:52:38 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP Modem connection impossible with 2.5.73-bk2
Message-Id: <20030626195238.673bcffd.diegocg@teleline.es>
In-Reply-To: <1056567978.931.8.camel@laurelin>
References: <1056567978.931.8.camel@laurelin>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jun 2003 21:06:18 +0200
Flameeyes <dgp85@users.sourceforge.net> wrote:

> Hi,
> After the upgrade from 2.5.73-bk1 to bk2 the pppd daemon is killed, so
> the ppp connection is impossible.
> After the reverse of the patch I can connect.
> I also applied the bk2-bk3 patch (without the bk2), and I have no
> problems.
> So the problem is in bk2.


I can confirm it.
Jun 25 00:11:09 estel chat[13737]:  -- got it 
Jun 25 00:11:09 estel chat[13737]: send (\d)
Jun 25 00:11:10 estel pppd[13734]: Serial connection established.
Jun 25 00:11:10 estel pppd[13734]: using channel 8
Jun 25 00:11:10 estel pppd[13734]: Using interface ppp0
Jun 25 00:11:10 estel pppd[13734]: Connect: ppp0 <--> /dev/ttyS1
Jun 25 00:11:11 estel pppd[13734]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magi
c 0x54b41996> <pcomp> <accomp>]
Jun 25 00:11:11 estel pppd[13734]: rcvd [LCP ConfReq id=0x1 <mru 1514> <asyncmap
 0x0> <auth chap MD5> <magic 0xf1833c0e> <mrru 1514> <endpoint [null]>]
Jun 25 00:11:11 estel pppd[13734]: sent [LCP ConfRej id=0x1 <mrru 1514>]
Jun 25 00:11:11 estel pppd[13734]: rcvd [LCP ConfRej id=0x1 <pcomp>]
Jun 25 00:11:11 estel pppd[13734]: sent [LCP ConfReq id=0x2 <asyncmap 0x0> <magi
c 0x54b41996> <accomp>]
Jun 25 00:11:11 estel pppd[13734]: Modem hangup
Jun 25 00:11:11 estel pppd[13734]: Connection terminated.
Jun 25 00:11:12 estel pppd[13734]: tcsetattr: Invalid argument
Jun 25 00:11:12 estel pppd[13734]: Exit.


Plain 2.5.73 works.
