Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTEQCDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbTEQCDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:03:13 -0400
Received: from maceio.ic.unicamp.br ([143.106.7.31]:18389 "EHLO
	maceio.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S264647AbTEQCDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:03:12 -0400
Date: Fri, 16 May 2003 23:16:03 -0300 (EST)
From: Felipe Massia Pereira <massia@ic.unicamp.br>
To: linux-kernel@vger.kernel.org
Subject: mtu_expires variable
Message-ID: <Pine.GSO.4.10.10305162243050.13822-100000@tigre.dcc.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been searching for the exact meaning of this variable through
Documentation and I've found just empty descriptions (to be filled in, in
Advanced Linux Routing HOWTO, and nothing also in
Documentation/networking/ip-sysctl.txt). I've tried also to read the
kernel source code (net/ipv4/route.c) but I could not figure out what they
mean.

I've came accross this var because we want to do some experiments in class
with Path MTU discovery.  But it happens that MTU is recorded between
experiments (and it's what we expect: that the stack does not do a PMTU
every time). BTW where is the PMTU value kept? Is MTU value recorded for
each destination or for each route?

So it would be nice if we could make the value found in a experiment to be
forgotten by the kernel so the students could execute the ping several
times. (ping -c 2 -m want ...) Is mtu_expires what we're looking for?

We tried to "echo 1 > /proc/sys/net/ipv4/route/mtu_expires" considering
that it's expressed in seconds. The usual value is 600. But I've read that
it's expressed in jiffies. Jiffies occur 100 times per sec on a PC, is it?
So the value 600 on a PC means 6 seconds?

tia, 
-- 
Felipe

