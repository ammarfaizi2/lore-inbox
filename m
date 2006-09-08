Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWIHWyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWIHWyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWIHWyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:54:40 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:15243 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751236AbWIHWyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:54:39 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 0/10] introduction: check pr_debug() arguments
Date: Fri,  8 Sep 2006 15:54:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

introduction: check pr_debug() arguments

I was recently frustrated when I broke the arguments to a pr_debug() call and
the bug went unnoticed until I defined DEBUG.  I poked around a bit and found
that I wasn't alone in breaking pr_debug() arguments.

Instead of having pr_debug() hide broken arguments when DEBUG isn't defined,
let's make it an empty inline and have gcc check it's format specifier.

What follows are the patches that fix up the existing bad pr_debug() calls.
The worst flat out get syntax wrong or reference non-existant symbols.

With those out of the way, the final patch makes the change to pr_debug().  The
net result doesn't affect a allyesconfig x86-64 build.  My apologies to other
builds that will be exposed to broken pr_debug() arguments.  What a great
opportunity to fix them!

- z
