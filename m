Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUCCEEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUCCEEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:04:23 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:44894 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262345AbUCCEEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:04:15 -0500
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021817050.9351@chaos>
	<404521B2.2030504@americasm01.nt.com>
	<Pine.LNX.4.53.0403022006250.9695@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 20:04:14 -0800
In-Reply-To: <Pine.LNX.4.53.0403022006250.9695@chaos>
Message-ID: <52vflmpoe9.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Mar 2004 04:04:14.0850 (UTC) FILETIME=[97872620:01C400D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> Well the device's poll function isn't getting called the
    Richard> second time with 2.6.0. I never checked it in 2.4.x
    Richard> because it always worked.  This problem occurs in a
    Richard> driver that only returns the fact that one event
    Richard> occurred. When it failed to report the event when built
    Richard> with a newer kernel, I added diagnostics which showed
    Richard> that the poll in the driver was only called once --and
    Richard> that the return from poll_wait happened immediately.

Your driver is buggy.  It's not surprising since you fundamentally
don't understand the kernel interface you're trying to use.

    Richard> So, if the poll_wait isn't a wait-function, but just some
    Richard> add-wakeup to the queue function, then its name probably
    Richard> should have been changed when it changed. At one time it
    Richard> did, truly, wait until it was awakened with
    Richard> wake_up_interruptible.

When did it change?  Show me a kernel version where poll_wait() waited
until the driver woke it up.  (Kernel versions at least as far back as
1.0 are readily available from kernel.org, so it should be easy for
you)

 - Roland
