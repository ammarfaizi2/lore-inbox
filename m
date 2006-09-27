Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWI0SFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWI0SFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbWI0SFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 14:05:34 -0400
Received: from main.gmane.org ([80.91.229.2]:37312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030500AbWI0SFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 14:05:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Markus Dahms <mad@automagically.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Wed, 27 Sep 2006 19:56:13 +0200
Message-ID: <pan.2006.09.27.17.56.13.80913@automagically.de>
References: <200609271424.47824.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9529ec8.dip0.t-ipconnect.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: linux-acpi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 27 Sep 2006 14:24:47 +0200 schrieb Rolf Eike Beer:

> I get this on my machine. SMP kernel, linus git from this morning. .config
> and test available on request.

I encountered a similar bug, but a lot earlier. It seems to be a locking
problem, as it is lockdep which does the BUG() for me.
It's also an SMP machine in my case, acpi_os_wait_semaphore() is in the
call chain, too. No textual output (no serial connection attached, too
early for netconsole), but a screenshot:

http://automagically.de/images/linux-2.6.18+-acpi-lockup.jpg (154kB)

2.6.18 works for me, newer git versions explode.

Maybe it's an SMP-related problem, but it does BUG() before initialization
of the second CPU.

Markus


