Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUGFVjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUGFVjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUGFVjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:39:41 -0400
Received: from hera.kernel.org ([63.209.29.2]:38017 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264628AbUGFVje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:39:34 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 1/2] Spinlock timeout
Date: Tue, 6 Jul 2004 14:39:21 -0700
Organization: Open Source Development Lab
Message-ID: <20040706143921.3abfef5f@dell_ss3.pdx.osdl.net>
References: <20040706161627.00f51cb0.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1089149962 10372 172.20.1.60 (6 Jul 2004 21:39:22 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 6 Jul 2004 21:39:22 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 16:16:27 -0500
Jake Moilanen <moilanen@austin.ibm.com> wrote:

> This will cause a BUG() when a spinlock is held for longer then X
> seconds.  It is useful for catching deadlocks since not all archs
> have a NMI watchdog.
> 
> It is also helpful to find locks that are held too long.
> 
> Please comment or apply.
> 
> Thanks,

Just don't ever run on a production or benchmark system because there are
cases where a lock can get hot and statistically take a real long time.
