Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbULHEcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbULHEcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 23:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbULHEcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 23:32:21 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:129 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S262016AbULHEcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 23:32:08 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Robert Olsson <Robert.Olsson@data.slu.se>, P@draigBrady.com
In-Reply-To: <20041207211035.GA20286@quickstop.soohrt.org>
References: <20041206205305.GA11970@soohrt.org>
	 <20041207211035.GA20286@quickstop.soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102480318.1050.16.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Dec 2004 23:31:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 16:10, Karsten Desler wrote:
> Karsten Desler <kdesler@soohrt.org> wrote:
> > Current packetload on eth0 (and reversed on eth1):
> >   115kpps tx
> >   135kpps rx
> 
> I totally forgot to mention: There are approximately 100k concurrent
> flows.

;-> Aha. That would make a huge difference. I know of noone
who has actually done this level of testing. I have tried upto about 50K
flows myself in early 2.6.x and was eventually compute bound.
Really try compiling out totaly iptables/netfilter - it will make a
difference.
You may also want to try something like LC trie algorithm that Robert
and co are playing with to see if it makes a difference with this many
flows. 

cheers,
jamal

