Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTJOGyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 02:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTJOGyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 02:54:24 -0400
Received: from ztxmail01.ztx.compaq.com ([161.114.1.205]:61958 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262158AbTJOGyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 02:54:23 -0400
Message-ID: <3F8CEFCE.33EF6836@toughguy.net>
Date: Wed, 15 Oct 2003 12:27:18 +0530
From: Raj <obelix123@toughguy.net>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: Javier Govea <jgovea@magma.ca>, linux-kernel@vger.kernel.org
Subject: Re: Source ports at the  IP layer
References: <200310142113.h9ELDsAp002223@webmail1.magma.ca> <20031014214231.GC16761@alpha.home.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > I also tried
> > struct tcphdr *th = (struct tcphdf *)skb->h.th;
> > and then printing out th->source...but i'm still getting 17664...any suggestion on how I
> > can get the ports??? All ideas are very very welcome...

A weird wild guess :-) . Possibly the source port is still in
network-byte-order. Try converting it to host-byte-order ( if your
machine arch is little-endian ) before printing. 

Network-byte-order 17664 = 69 in little-endian which is tftp.

/Raj
