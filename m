Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTEAGPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTEAGPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:15:42 -0400
Received: from dp.samba.org ([66.70.73.150]:39855 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262676AbTEAGPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:15:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loading a module multtiple times 
In-reply-to: Your message of "Wed, 30 Apr 2003 22:10:37 MST."
             <33490.4.64.196.31.1051765837.squirrel@www.osdl.org> 
Date: Thu, 01 May 2003 16:22:10 +1000
Message-Id: <20030501062800.3B9652C01B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <33490.4.64.196.31.1051765837.squirrel@www.osdl.org> you write:
> Argh, I looked thru insmod.c but not modprobe.c for a solution.

Well, you *could* do:

	for i in `seq 1 9`; do
		sed "s/dummy/dumm$i/g" < dummy.ko > dumm$i.ko
		insmod dumm$i.ko
	done

But don't 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
