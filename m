Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUEAPYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUEAPYP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 11:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEAPYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 11:24:15 -0400
Received: from fionet.com ([217.172.181.68]:57230 "EHLO service.fionet.com")
	by vger.kernel.org with ESMTP id S262213AbUEAPYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:24:14 -0400
Subject: Re: Problem spawning init from script
From: Joe Schulz <joe@spamfilter.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405010014.07259.vda@port.imtp.ilyichevsk.odessa.ua>
References: <c6suq3$ko7$1@sea.gmane.org>
	 <200405010014.07259.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083425043.13689.24.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 01 May 2004 17:24:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2004-04-30 at 23:14, Denis Vlasenko wrote:

> > Kernel panic: Attempted to kill init!
> 
> This typically means that process #1 exited. Kernel does not like that.
> I always use 'exec /path/something' as the last command in my sh scripts
> which I start instead of 'standard' /sbin/init.
> 
> Post your script.

I have found the reason. Due to a linking problem, the exec'ed process
always quietly died. Of course only in the boot process, not during
dry-run testing. So I had falsely assumed that exec'ing from #1 might
always lead to a panic if you don't use the initrd procedure.

Thanks four your kind advice.

br, Joe
