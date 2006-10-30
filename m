Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWJ3OYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWJ3OYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWJ3OYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:24:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42205 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751769AbWJ3OYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:24:05 -0500
Date: Mon, 30 Oct 2006 06:23:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030062332.856dcc32.pj@sgi.com>
In-Reply-To: <45460743.8000501@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	<45460743.8000501@openvz.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel wrote:
> 1. One of the major configfs ideas is that lifetime of
>    the objects is completely driven by userspace.
>    Resource controller shouldn't live as long as user
>    want. It "may", but not "must"!

I had trouble understanding what you are saying here.

What does the phrase "live as long as user want" mean?


> 2. Having configfs as the only interface doesn't alow
>    people having resource controll facility w/o configfs.
>    Resource controller must not depend on any "feature".
>
> 3. Configfs may be easily implemented later as an additional
>    interface. I propose the following solution:
>      - First we make an interface via any common kernel
>        facility (syscall, ioctl, etc);
>      - Later we may extend this with configfs. This will
>        alow one to have configfs interface build as a module.

So you would add bloat to the kernel, with two interfaces
to the same facility, because you don't want the resource
controller to depend on configfs.

I am familiar with what is wrong with kernel bloat.

Can you explain to me what is wrong with having resource
groups depend on configfs?  Is there something wrong with
configfs that would be a significant problem for some systems
needing resource groups?

It is better where possible, I would think, to reuse common
infrastructure and minimize redundancy.  If there is something
wrong with configfs that makes this a problem, perhaps we
should fix that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
