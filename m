Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUJJLc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUJJLc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 07:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUJJLc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 07:32:28 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:37811 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S268251AbUJJLc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 07:32:27 -0400
Date: Sun, 10 Oct 2004 07:31:52 -0400
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041010113152.GA9064@escher.cs.wm.edu>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041010104113.GC28456@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your filesystem handling code is completely superflous (and buggy).  Please
> remove all the code dealing with chroot-lookalikes.  In your userland script
> you simpl have to clone(.., CLONE_NEWNS) to detach your namespace from your
> parent, then you can lazly unmount all filesystems and setup your new namespace
> before starting the jail.  The added advantage is that you don't need any
> cludges to keep the user from exiting the chroot.

I definately would prefer to use namespaces.  I had originally wanted to
do a copy_namespace() in the module.  That function is not exported,
though.  Is doing that in user-space really the right way to do it?

thanks,
-serge
