Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270867AbRHNVIN>; Tue, 14 Aug 2001 17:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270866AbRHNVID>; Tue, 14 Aug 2001 17:08:03 -0400
Received: from mail.zabbadoz.net ([195.2.176.194]:10761 "EHLO
	mail.zabbadoz.net") by vger.kernel.org with ESMTP
	id <S270869AbRHNVHr>; Tue, 14 Aug 2001 17:07:47 -0400
Date: Tue, 14 Aug 2001 23:07:44 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: Chris Crowther <chrisc@shad0w.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <Pine.LNX.4.33.0108142137300.3810-100000@monolith.shad0w.org.uk>
Message-ID: <Pine.BSF.4.30.0108142300240.38503-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Chris Crowther wrote:

> 	Hmm, looking at CDP there isn't really any reason to put it in
> userspace either, it doesn't need to be configured, it doesn't pass

That's wrong:

cisco-switch(config)#cdp ?
  advertise-v2  CDP sends version-2 advertisements
  holdtime      Specify the holdtime (in sec) to be sent in packets
  timer         Specify the rate at which CDP packets are sent (in sec)
  run

it can be enabled/disables on a per interface base.

There are also some different output possibilitites on cisco:
sh cdp
and:
sh cdp run
sh cdp timer
sh cdp traffic
and (no the interesting parts within here):
sh cdp neigh <detail>
sh cdp entry <*> <WORD>
sh cdp interface ..


> at the neighbor summary.  I can't see any real advantages of running it as
> a daemon as opposed to a kernel component.

portability ? linux is not the only OS in world. Think about running
on *BSD, Solaris, AIX, HPUX, ...


-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

