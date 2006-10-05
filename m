Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWJEH6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWJEH6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWJEH6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:58:42 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:36315 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751171AbWJEH6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:58:41 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Markus Wenke <M.Wenke@web.de>
Subject: Re: to many sockets ?
Date: Thu, 5 Oct 2006 09:58:37 +0200
User-Agent: KMail/1.9.4
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <4523CD4E.10806@web.de> <1159979587.25772.82.camel@localhost.localdomain> <4524B0E9.8010005@web.de>
In-Reply-To: <4524B0E9.8010005@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050958.38036.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 09:14, Markus Wenke wrote:

> I tried the same scenario with SO_SNDBUF = SO_RCVBUF = 8k, so that the
> max memory is ca. 2G
> and the oom-killer kills my application at the same time (at 140000
> connections).
>
> I can not see in the messages that the system is out of memory,
> there is also no swap space used
>
> You can download my /var/log/messages at
> http://hemaho.mine.nu/~biber/messages
>
> May you can give me a hint which line/value in the log shows me,
> that the system is out of memory?

I think you lack of LOWMEM, since you use a 32bits kernel.

Could you post here the result of these commands when your system is using 
more than 100.000 connections (and before the OOM :) )

cat /proc/meminfo
cat /proc/slabinfo
cat /proc/net/sockstat
cat /proc/net/stat/rt_cache
cat /proc/buddyinfo
grep . /proc/sys/net/ipv4/*
grep . /proc/sys/net/ipv4/route/*

Eric
