Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268559AbTGNIyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268552AbTGNIww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:52:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:59028 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268476AbTGNIwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:52:46 -0400
Message-Id: <5.2.1.1.2.20030714101440.01bd1740@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 14 Jul 2003 11:11:45 +0200
To: Jamie Lokier <jamie@shareable.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy
  ...
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030714072449.GE24031@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:24 AM 7/14/2003 +0100, Jamie Lokier wrote:
>Mike Galbraith wrote:
> > I also had some sound skips due to inheritance.  If I activate
> > xmms's gl visualization under load, it inherits SCHED_SOFTRR, says
> > "oink" in a very deep voice, and other xmms threads expire.  Maybe
> > tasks shouldn't inherit SCHED_SOFTRR?
>
>That's likely a bug in xmms - it shouldn't be passing the normal
>SCHED_RR state to the gl visualizer.

If I set xmms SCHED_RR, it does drop it for the visualizer.  (I promptly 
re-set it to test the X oddness) I presume it's stumbling over the policy.

         -Mike 

