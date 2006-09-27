Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWI0NL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWI0NL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWI0NL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:11:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56220 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751139AbWI0NL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:11:57 -0400
Date: Wed, 27 Sep 2006 09:11:23 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Stupid kexec/kdump question...
Message-ID: <20060927131123.GA2514@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu> <20060926221029.d9e87650.akpm@osdl.org> <20060927052737.GA17214@verge.net.au> <m1u02toi2g.fsf@ebiederm.dsl.xmission.com> <200609271251.k8RCpp6X029724@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609271251.k8RCpp6X029724@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 08:51:50AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 27 Sep 2006 02:00:07 MDT, Eric W. Biederman said:
[..]
> > At that level I would say that below 32M is where you start dealing with
> > custom built programs, instead of slapping a bunch of utilities inside
> > a ramdisk.  I suspect with a little care you could get a few K user
> > space executable and fit everything inside of 4M.  But I don't know if anyone
> > is that ambitious yet.
> 
> Well, the stripped down kernel is right around 2M.  Unfortunately, I need
> to run lvm.static, which is another 1.5M at least.  So unless busybox has
> grown support for LVM, I'm looking at 8M at best.
> 
> Another stupid question - I see how the first kernel gets the 'crashkernel='
> parameter and knows how much space there is.  But if you set it to 32M@16M,
> how does the kdump kernel know it only has 32M?  Or does it just start at
> the 16M line, and it's your job to make sure it doesn't go over the 48M line
> and start corrupting the dump?
> 

Kdump kernel is booted with User defined memory map. For this purpose
kexec-tools passes memmap=exactmap option on command line to the second
kernel. Hence second kernel execution is bounded within reserved memory
region.

-Vivek
