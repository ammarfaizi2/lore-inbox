Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVD0KUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVD0KUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVD0KUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:20:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:39380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261360AbVD0KUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:20:36 -0400
Date: Wed, 27 Apr 2005 03:19:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on
 AMD64
Message-Id: <20050427031956.7fd67b31.akpm@osdl.org>
In-Reply-To: <200504271152.15423.rjw@sisk.pl>
References: <200504271152.15423.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> I'm having a problem with 2.6.12-rc3 and the Java VM (from SuSE 9.2)
> on AMD64.  Namely, after trying to open a web page containing a Java
> applet, my browser starts a java process that takes almost 100% of the CPU
> (system load, according to gkrellm) and cannot be killed (even by root,
> although it executes with a non-root UID).  Apparently, it is in TASK_RUNNING
> (according to ps).
> 
> The problem is 100% reproducible (it is enough to visit
> http://java.sun.com/docs/books/tutorial/getStarted/index.html to trigger it)
> and it does not depend on the web browser used.
> 
> The Java JRE version is:
> 
> java version "1.4.2_06"
> Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_06-b03)
> Java HotSpot(TM) Client VM (build 1.4.2_06-b03, mixed mode)
> 
> (I guess it's 32-bit, but I'm not quite sure) and I've installed it from the
> SuSE 9.2 RPM.
> 
> It really is a show stopper to me, so please advise.

Where is it running?

You can tell this from a kernel profile, or by using sysrq-P five or ten
times then looking at the output.

