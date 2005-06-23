Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVFWWT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVFWWT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVFWWTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:19:24 -0400
Received: from unused.mind.net ([69.9.134.98]:55513 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262766AbVFWWOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:14:00 -0400
Date: Thu, 23 Jun 2005 15:11:52 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050623001023.GC11486@elte.hu>
Message-ID: <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org>
References: <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com>
 <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
 <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
 <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org>
 <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org>
 <20050623001023.GC11486@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, Ingo Molnar wrote:

> yes, very likely hardware (or system BIOS, e.g. SMM) induced.

Running -50-17 on the Xeon/HT box, now with the ICH5 USB controller
disabled in BIOS.

The strangely regular ~200us idle jumps for both CPUs went away.  Now I'm
seeing one CPU at a time disappear (often completely absent) in the 
traces, with a the maximum wakeup generally hitting between 150us and 
300us.  While compiling a kernel and running vlc (which would skip frames 
like mad, even with RR scheduling) I was able to get one trace of 2556us.

There's also BUG warnings for update_out_trace().  I'm not quite sure if 
the trace behavior I'm seeing is related to this bug, but judging by the 
behavior of vlc, I wouldn't bet on it.

Since the 2556us trace is quite large all the info is posted at:

http://sysex.net/testing/2.6.12-RT-V0.7.50-17/xeonht/


--ww
