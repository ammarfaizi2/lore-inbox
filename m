Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUKWWDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUKWWDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUKWWCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:02:01 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62368 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261432AbUKWV7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:59:53 -0500
Subject: Re: SELinux performance issue with large systems (32 cpus)
From: keith <kmannth@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: devnull@us.ibm.com, djwong <djwong@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041123125212.E14339@build.pdx.osdl.net>
References: <1101237725.27848.301.camel@knk>
	 <20041123125212.E14339@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1101247189.27848.307.camel@knk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Nov 2004 13:59:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 12:52, Chris Wright wrote:
> * keith (kmannth@us.ibm.com) wrote:
> > I work with i386 16-way systems.  When hyperthreading is enabled they
> > have 32 "cpus".  I recently did a quick performance check on with 2.6
> > (as it turn out with a SElinux enabled) doing kernel builds.  
> 
> Have you tried any recent -mm kernel?  avc_lock was refactored to RCU
> locking, and benchmarks shows it scales quite nicely now.

I just tried 2.6.10-rc2-mm3 on my box.  The patches in mm fix the
avc_lock problem.  The refactoring of the lock worked :)

Thanks,
 Keith Mannthey 
 LTC xSeries

