Return-Path: <linux-kernel-owner+w=401wt.eu-S1754982AbWL1VAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbWL1VAF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbWL1VAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:00:05 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:63264 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982AbWL1VAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:00:03 -0500
Date: Thu, 28 Dec 2006 12:58:05 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-Id: <20061228125805.2edc0a2b.randy.dunlap@oracle.com>
In-Reply-To: <20061228124644.4e1ed32b.akpm@osdl.org>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
	<20061228124644.4e1ed32b.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 12:46:44 -0800 Andrew Morton wrote:

> On Thu, 28 Dec 2006 21:27:40 +0100 (CET)
> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> 
> > After Al Viro (finally) succeeded in removing the sched.h #include in 
> > module.h recently, it makes sense again to remove other superfluous 
> > sched.h includes.
> 
> Why are they "superfluous"?  Because those compilation
> units pick up sched.h indirectly, via other includes?

I'm half done with a patch to remove includes of smp_lock.h.
For the files that I have patched, I checked each source file
for all interfaces in smp_lock.h to verify that none of them
are used, so the #include is just waste.

> If so, is that a thing we want to do?

Nope.

---
~Randy
