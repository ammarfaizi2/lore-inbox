Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVBZQ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVBZQ7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVBZQ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:59:23 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:29089 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261233AbVBZQ7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:59:20 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: how to use schedule_work()
Date: Sat, 26 Feb 2005 16:59:18 +0000
Message-Id: <022620051659.7657.4220AAE60003033B00001DE9220588448400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> hai all,
>     I want to call call_usermodehelper() from schedule_work() to run the
> user program in the process context. Can u please tell me how to call 
> schedule_work(), plz give any reference manual for that.
> 
Download cscope from cscope.sourceforge.net - The site has a good tutorial on using it with linux kernel. (It's a source code searching tool - you can find for example, all functions that call a particular function and so on.) I find it very useful when you want to understand things from source code.

Then find for schedule_work, look into the source where it is used and see if you can comprehend it that way.

In essence - you need to setup and initialize a struct work_struct (this cannot be on a function local stack since callers stack will not be available when the work is executed) fill it with function to be called and arguments to be passed and then call schedule_work from say an interrupt.

Parag



