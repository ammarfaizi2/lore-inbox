Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVKPUX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVKPUX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbVKPUX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:23:29 -0500
Received: from nikola.com ([64.146.180.228]:12401 "EHLO nikola.com")
	by vger.kernel.org with ESMTP id S1030465AbVKPUX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:23:28 -0500
Message-ID: <009401c5eaeb$9a77be00$5e00800a@printserver>
From: "Jesse Gordon" <jesseg@nikola.com>
To: <linux-kernel@vger.kernel.org>
References: <200511121616.14940.ace@staticwave.ca> <200511161252.08927.bjorn.helgaas@hp.com>
Subject: ICMP Ping being lost between kernel and the ping program.
Date: Wed, 16 Nov 2005 12:23:27 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-Authenticated-Sender: jesseg@nikola.com
X-Spam-Processed: nikola.com, Wed, 16 Nov 2005 12:23:23 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 64.146.180.228
X-Return-Path: jesseg@nikola.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: nikola.com, Wed, 16 Nov 2005 12:23:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings. This is my first post.

I'm having a weird intermittent problem with ping.

I'm pinging the WAN port of a cheap home DSL firewall (d-link di-604) and 
sometimes the ping program fails to get a response,
but if I run tcpdump I can see that the response is indeed coming back.

arping on the target IP always works.

We're a small wireless ISP with 40ish customers -- each of whom has a cheap 
dlink router at their home. We ping each of them regularly to be notified of 
a wireless loss of connection.
(The wireless is Trango running at 5.x Ghz or ~900Mhz -- not 802.11) and all 
the wireless and switches are just ethernet bridges -- so it's a flat 
network with no ip based routing.

Two different dlink routers cause this problem but not necisarly at the same 
time.

Two different Linux computers exhibit this problem, although again, not 
always at the same time. One seems to be more picky -- sometimes just the 
picky one has a problem, other times they both have the problem.

Also, I have not yet noticed this problem while pinging from a windows 
computer.

Picky one:Linux 2.4.26
Less picky one: Linux 2.6.11.11 SMP

Anyhow, I don't know whether the dlinks are sometimes sending out sligly 
malformed packets, whether they are getting slightly damaged over the 
wireless network,
or whether Linux [the kernel] is having a problem, or if the ping program is 
having the problem. The facts just don't make sense for any of those.

I'll be glad to do all the normal stuff -- upgraded to latest kernel, (I did 
try upgrading to latest ping not too long ago no help - can try again),  if 
anyone thinks that'll help me solve the mystery.
I can even capture the text description of or the raw contents of packets 
with tcpdump or maybe ethereal, if that will help.

I did one time capture with ethereal a packet when ping was working, then a 
packet when it wasn't and compared them side by side in two ethereal 
instances -- and aside from the fields that should have been different, 
everything looked the same.

Thanks! 


