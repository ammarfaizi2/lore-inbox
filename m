Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbSI3VoL>; Mon, 30 Sep 2002 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261359AbSI3VoL>; Mon, 30 Sep 2002 17:44:11 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:27211 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261344AbSI3VoJ>; Mon, 30 Sep 2002 17:44:09 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758A6C@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Arnd Bergmann'" <arnd@bergmann-dalldorf.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [patch] e100 schedule while atomic
Date: Mon, 30 Sep 2002 14:48:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:

> Running e100 on linux-2.5.39 showed that the driver 
> incorrectly holds a lock while calling request_irq(), which 
> does kmalloc().
> 
> This patch appears to solve the problem. Not sure if it is 
> correct, but something like it has to be done.

Thanks for pointing this out.  I don't think the lock needs to be held at
all in e100_open, so we'll look into cleaning that up.  Regardless, we'll
included a fix for this problem in our next set of patches to Jeff.

-scott
