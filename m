Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUH3U1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUH3U1C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUH3U1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:27:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:44163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268914AbUH3U0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:26:45 -0400
Date: Mon, 30 Aug 2004 13:26:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Window Scaling problem with buggy routers FIX works
Message-Id: <20040830132632.4c34f336@dell_ss3.pdx.osdl.net>
In-Reply-To: <512805293.20040830130037@dns.toxicfilms.tv>
References: <512805293.20040830130037@dns.toxicfilms.tv>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 13:00:37 +0200
Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

> Hi,
> 
> I am just letting you guys know that the fix for
> tcp window scaling problem with buggy routers works.

As mentioned in the patch to automatically manage tcp window
scale size. This was an (mostly unwanted) side-effect.

> There were people (including me) reporting that tcp traffic
> through some buggy (eg. cisco) routers in linux-2.6.8 slows
> down to a crawl.

Find and fix the problem. It may come back.

> A workaround was to zero tcp_window_scaling sysctl knob.
> 
> With this patch:
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-shemminger@osdl.org|ChangeSet|20040826205608|22084.txt
> 
> sitting in 2.6.9-rc1 BK repository the linux box can have
> fast transfers again.
> 
> Note that they are not that fast as with tcp_window_scaling disabled.
> But they are certainly fast and will not cause problems like
> ssh sessions hangning, etc.

That is because every time the linux box says the window size is N.
The other side is thinking the window is N/4 because the router in
the middle corrupted the initial connection requuest.


> Thanks for the workaround for buggy routers netdev!

Don't expect the default Linux kernel configuration to work
on broken networks.


-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
