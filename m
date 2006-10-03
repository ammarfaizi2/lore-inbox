Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWJCPdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWJCPdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWJCPdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:33:52 -0400
Received: from fgi-entwicklung.de ([217.160.210.131]:50067 "EHLO
	p15132913.pureserver.info") by vger.kernel.org with ESMTP
	id S1030225AbWJCPdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:33:51 -0400
Message-ID: <452282DE.5020600@arndnet.de>
Date: Tue, 03 Oct 2006 17:33:50 +0200
From: Arnd Hannemann <arnd@arndnet.de>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Irfan Habib <irfan.habib@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Any way to find the network usage by a process?
References: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com> <3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>
In-Reply-To: <3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Irfan Habib schrieb:
> Hi,
> 
> Is there any method either kernel or user level which tells me which
> process is generating how much traffic from a machine. For example if
> some process is flooding the network, then I would like to know which
> process (PID ideally), is generating the most traffic.

If you want to monitor just specific PIDs you could easily do this with
the "Owner match support" from netfilter. However if you also want to
monitor traffic for all processes that may be created in the future this
is probably a bit tricky. Off course you could try to add a rule for
every possible PID ;-)
Seriously, you could write a daemon which permanently scans for new or
died processes and which adds/deletes appropriate netfilter rules...

Best regards
Arnd Hannemann
