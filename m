Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTISCo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 22:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTISCo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 22:44:56 -0400
Received: from dp.samba.org ([66.70.73.150]:64138 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261151AbTISCoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 22:44:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Make modules_install doesn't create /lib/modules/$version 
In-reply-to: Your message of "Thu, 18 Sep 2003 09:15:11 MST."
             <20030918091511.276309a6.rddunlap@osdl.org> 
Date: Fri, 19 Sep 2003 12:25:56 +1000
Message-Id: <20030919024455.834992C0F1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030918091511.276309a6.rddunlap@osdl.org> you write:
> On Thu, 18 Sep 2003 03:21:40 -0400 Rob Landley <rob@landley.net> wrote:
> 
> | I've installed -test3, -test4, and now -test5, and each time make 
> | modules_install died with the following error:
> | 
> | Kernel: arch/i386/boot/bzImage is ready
> | sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
> | /lib/modules/2.6.0-test5 is not a directory.

Looks like arch/i386/boot/install.sh is calling ~/bin/installkernel or
/sbin/installkernel, which is not creating the directory.

Should depmod create the directory?  It can, of course, but AFAICT the
old one didn't.

Maybe a RedHat issue?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
