Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVBRUNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVBRUNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVBRUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:09:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:34965 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261499AbVBRUJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:09:01 -0500
Subject: Re: 2.6.10-ac12 + kernbench == oom-killer: (OSDL)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cliff White <cliffw@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1D2BPv-0006T3-Q6@es175>
References: <20050208145707.1ebbd468@es175>
	 <20050209013617.GC2686@pclin040.win.tue.nl>  <E1D2BPv-0006T3-Q6@es175>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108757251.17213.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 18 Feb 2005 20:07:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-02-18 at 16:55, Cliff White wrote:
> Okay, with just vm.overcommit=2, things are still bad:
> http://khack.osdl.org/stp/300854/logs/TestRunFailed.console.log.txt
> 
> Suggestion for vm.overcommit_ratio ?
> Or should i repeat with later -ac ?

Thats showing up problems in the core code still. The OOM in this case
is because the kernel is deciding it is out of memory when it's merely
constipated with dirty pages for disk write by the look of it.

Alan
