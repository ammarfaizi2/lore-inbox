Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUHZSS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUHZSS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUHZSOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:14:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46760 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269197AbUHZSGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:06:13 -0400
Subject: Re: Disable kscand/Normal?
From: Lee Revell <rlrevell@joe-job.com>
To: "HOLTZ, CORBIN L. (JSC-ER) (LM)" <corbin.l.holtz1@jsc.nasa.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <A850C6B3EB02F044907B475259FFF56501724A18@jsc-mail08.jsc.nasa.gov>
References: <A850C6B3EB02F044907B475259FFF56501724A18@jsc-mail08.jsc.nasa.gov>
Content-Type: text/plain
Message-Id: <1093543394.5678.64.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 14:03:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 23:54, HOLTZ, CORBIN L. (JSC-ER) (LM) wrote:
> I'm currenty
> building a realtime visualization system for a Space Shuttle landing
> simulator at NASA.  I'm using a small network of 5 Pentium 4 computers
> running RedHat's 2.4.20-31.9 kernel.  I'm easily running 60 frames/second on
> my systems, but I'm having a problem because the kscand/Normal thread comes
> in every 25 seconds and causes me to drop a frame (very annoying).  I've
> looked into the kernel source and found where the kscand threads are
> spawned.  I also see where the 25 second period is coming from.  What I'm
> wondering is what would happen if I disabled the kscand/Normal thread?  I've
> got plenty of memory, and my process is the only thing running on the
> system.  Would I eventually see problems, or would I be OK since I'm not
> running low on memory?  What if I modified the kernel to allow me to
> temporarily disable the thread while my application is running (using a
> /proc file or something similar)?

You should also look into Ingo Molnar's voluntary preemption patches for
a more general way to do soft and even hard realtime with Linux.  Con's
suggestion will probably solve the kscand problem but the voluntary
preemption patches provide a more general way to deal with real time
constraints.  Check the LKML archives for the past few months, there has
been a lot of work in this area lately.

Lee

