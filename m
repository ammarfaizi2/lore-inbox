Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTIMJNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbTIMJNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:13:12 -0400
Received: from smtp.mailix.net ([216.148.213.132]:21391 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S262101AbTIMJNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:13:10 -0400
Date: Sat, 13 Sep 2003 11:13:06 +0200
From: Alex Riesen <fork0@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.0-test5-mm1
Message-ID: <20030913091306.GA3658@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908235028.7dbd321b.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> really-use-english-date-in-version-string.patch
>  really use english date in version string

-  echo \#define LINUX_COMPILE_TIME \"`LANG=C date +%T`\"
+  echo \#define LINUX_COMPILE_TIME \"`LC_ALL=C LANG=C date +%T`\"

LC_ALL overrides everything, so LANG is not needed anymore. Should be:

+  echo \#define LINUX_COMPILE_TIME \"`LC_ALL=C date +%T`\"

