Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbULLFGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbULLFGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 00:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbULLFGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 00:06:36 -0500
Received: from fsmlabs.com ([168.103.115.128]:54243 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261744AbULLFGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 00:06:35 -0500
Date: Sat, 11 Dec 2004 22:06:16 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041205232007.7edc4a78.akpm@osdl.org> <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
 <20041206160405.GB1271@us.ibm.com> <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
 <20041206192243.GC1435@us.ibm.com> <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Zwane Mwaikambo wrote:

> Introduce cpu_idle_wait() on architectures requiring modification of 
> pm_idle from modules, this will ensure that all processors have updated 
> their cached values of pm_idle upon exit. This patch is to address the bug 
> report at http://bugme.osdl.org/show_bug.cgi?id=1716 and replaces the 
> current code fix which is in violation of normal RCU usage as pointed out 
> by Stephen, Dipankar and Paul.

Aargh, i shouldn't be programming whilst sick :( i'll repost a non broken 
version shortly.

