Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTIKXpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIKXpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:45:18 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:63248 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261601AbTIKXpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 19:45:14 -0400
Date: Thu, 11 Sep 2003 20:47:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Andrew de Quincey <adq_dvb@lidskialf.net>
cc: linux-kernel@vger.kernel.org, <linux-dvb@linuxtv.org>, <franck@nenie.org>,
       <eric@lammerts.org>
Subject: Re: Possible kernel thread related crashes on 2.4.x (fwd)
Message-ID: <Pine.LNX.4.44.0309112047200.3887-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Sep 2003, Andrew de Quincey wrote:

> Hi, I've been having fatal oopses with some of my DVB receiver systems 
> when restarting streaming recently (i.e. opening/closing DVB devices). 
> I've only just got into the office with a debug cable to find out what has happening.
> 
> Anyway, here are the important parts of the oops (full oops at end of mail):
> Unable to handle kernel paging request at virtual address d905a984
> ...
> Trace; c011c79c <free_uid+2c/34>
> Trace; c011767b <release_task+2b/16c>
> Trace; c0118337 <sys_wait4+307/390>
> Trace; c0106c03 <system_call+33/38>
> 
> Does this look familiar to anyone? I mean specifically this thread on linux-dvb (among others):
> http://www.linuxtv.org/mailinglists/linux-dvb/2003/04-2003/msg00291.html
> 
> Searching about found me this patch on LKML:
> http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week04/0468.html
> 
> Which I applied to 2.4.21, and which appears to fix the problem. At least,
> I was able to continually restart streaming for 4 hours this afternoon without a problem. 
> Previously, I could crash it within 15 minutes.
> 
> It seems to be a bug related to kernel threads when starting/stopping them. The DVB drivers 
> now do this when a DVB device is opened/closed, although I'm sure they previously left 
> them running which would explain why I never saw this behaviour before.
> 
> My question is: is there a reason the patch has not yet made it into 2.4.x? It is not in 
> 2.4.22-pre3.

It seems good.

Just applied in the BK tree.

Please CC me in messages related to 2.4 :)

Thanks


