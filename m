Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTJNVOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJNVOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:14:03 -0400
Received: from mx2.magma.ca ([206.191.0.250]:30657 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S262071AbTJNVOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:14:00 -0400
Date: Tue, 14 Oct 2003 17:13:54 -0400 (EDT)
Message-Id: <200310142113.h9ELDsAp002223@webmail1.magma.ca>
To: linux-kernel@vger.kernel.org
From: "Javier Govea" <jgovea@magma.ca>
Subject: Source ports at the  IP layer
X-Account: jgovea
X-Sender-IP: 209.217.122.119
X-INFO: Folder - 0, Message - 0, MimeBody - 0
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I want to get the source ports of every incomming IP packet at the IP layer, but I'm
having problems. 

A print out, in the ip_rcv() function (in ip_input.c), of skb->h.uh->source (for the UDP
source port) and of skb->h.th->source (for the TCP source port) is always displaying 17664
(and i'm sure that is not the real source port). What am i doing wrong?? Is it possilble
at all to get the source ports directly from skb->h.th->source at this early stage, i mean
at the IP layer?? Do i need to do some casting or calling another function before i can
get the ports??? 

I also tried  
struct tcphdr *th = (struct tcphdf *)skb->h.th;
and then printing out th->source...but i'm still getting 17664...any suggestion on how I
can get the ports??? All ideas are very very welcome...

Thanx in advance...
Xavier
