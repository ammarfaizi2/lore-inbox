Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUKSQdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUKSQdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUKSQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:33:10 -0500
Received: from main.gmane.org ([80.91.229.2]:53687 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261450AbUKSQbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:31:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: 2.6 and route nat. Who know what is going on?
Date: Fri, 19 Nov 2004 19:31:34 +0300
Message-ID: <pan.2004.11.19.16.31.34.51328@altlinux.ru>
References: <200411191720.13423.pvolkov@mics.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.177.124.23
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004 17:20:13 +0300, Peter Volkov Alexandrovich wrote:

> Short question: Must "route nat", mentioned in ip-cref documentation coming 
> with iproute2 package, work with 2.6.9 kernel?

Support for CONFIG_IP_ROUTE_NAT was removed from the kernel - it has been
broken by some networking changes, and nobody bothered to fix it.

See this thread in linux-netdev:

http://marc.theaimsgroup.com/?l=linux-netdev&m=109582576330019&w=2

You can use netfilter (iptables etc.) for NAT and more, but probably it
will consume more resources than the old "route nat" code.

