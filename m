Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270030AbTGPBhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270023AbTGPBhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:37:12 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:62128 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S270022AbTGPBhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:37:00 -0400
To: hadi@cyberus.ca
Cc: "David S. Miller" <davem@redhat.com>, Jordi Ros <jros@xiran.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, alan@storlinksemi.com
Subject: Re: TCP IP Offloading Interface
References: <E3738FB497C72449B0A81AEABE6E713C027A43@STXCHG1.simpletech.com>
	<20030714225133.18395b69.davem@redhat.com>
	<1058329895.1796.28.camel@jzny.localdomain>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 15 Jul 2003 18:51:39 -0700
In-Reply-To: <1058329895.1796.28.camel@jzny.localdomain>
Message-ID: <52fzl7s0gk.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Jul 2003 01:51:42.0276 (UTC) FILETIME=[CE006840:01C34B3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    jamal> What about infiniband which has all this built in
    jamal> offloading?

We're seeing some pretty good numbers (well above 5 Gb/sec, basically
PCI-X 64bit/133MHz limited) with sockets direct (SDP) on top of
InfiniBand.  This is running standard sockets applications, just using
the AIO patches for kernel 2.4.  Latency is also much better than TCP
on top of ethernet, although this is mostly just due to the
underlying transport.

 - Roland
