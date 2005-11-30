Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVK3ATS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVK3ATS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVK3ATS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:19:18 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10395
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751428AbVK3ATS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:19:18 -0500
Date: Tue, 29 Nov 2005 16:18:49 -0800 (PST)
Message-Id: <20051129.161849.132625522.davem@davemloft.net>
To: sfrost@snowman.net
Cc: torvalds@osdl.org, mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051129164946.GP6026@ns.snowman.net>
References: <438C80DD.7050809@m1k.net>
	<Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
	<20051129164946.GP6026@ns.snowman.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Frost <sfrost@snowman.net>
Date: Tue, 29 Nov 2005 11:49:46 -0500

> I'm pretty curious about it too, none of my debian-based boxes have
> 'gdb' anywhere in /etc/init.d.  The only thing I see is that the shell
> script /usr/bin/mozilla-firefox calls gdb when passed '--debugger', or
> when the DEBUG environment variable is set...  Perhaps he's doing that
> during his .xsession?

There are a bunch of programs out there which fork and fire up
gdb and attach it to themselves if they take a SIGSEGV or
SIGBUS.  Printing out the parent process of the gdb will
likely reveal the exact case.

