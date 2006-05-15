Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWEOT4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWEOT4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWEOT4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:56:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:235 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751498AbWEOT4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:56:33 -0400
Subject: Re: Segfault on the i386 enter instruction
From: Lee Revell <rlrevell@joe-job.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andi Kleen <ak@muc.de>, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4468D8CA.6070702@aknet.ru>
References: <44676F42.7080907@aknet.ru> <20060515074019.GA33242@muc.de>
	 <4468B733.7010101@aknet.ru> <20060515184401.GA89194@muc.de>
	 <4468D8CA.6070702@aknet.ru>
Content-Type: text/plain
Date: Mon, 15 May 2006 15:56:30 -0400
Message-Id: <1147722991.13948.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 23:38 +0400, Stas Sergeev wrote:

> > It is set by a few distributions (for use with flexmmap) in PAM, but
> > not by all. The kernel defaults don't have it.
> That might explain why I get
> $ ulimit -s
> 8192
> on fedora core.
> Thanks for explanations.

Just FYI, this does actually have an important effect on multithreaded
programs - glibc will allocate RLIMIT_STACK for each thread stack.  If
mlockall() is used this can eat quite a bit of memory.  It's a real
world problem for some pro audio apps.

Lee

