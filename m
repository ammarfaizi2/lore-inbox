Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbTIDVvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbTIDVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:51:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39180
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265578AbTIDVu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:50:58 -0400
Date: Thu, 4 Sep 2003 14:50:59 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030904215059.GG13676@matchmail.com>
Mail-Followup-To: James Clark <jimwclark@ntlworld.com>,
	linux-kernel@vger.kernel.org
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <20030904202707.GF13676@matchmail.com> <200309042216.03958.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309042216.03958.jimwclark@ntlworld.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:16:03PM +0100, James Clark wrote:
> I agree that at first sight the two concepts (Binary 'plugins' and GPL) don't 
> mix well but this is actually FUD which obscures the issue of making the 
> kernel much easier to deal with for the masses. 

There is some point in easing the use of external modules with a binary
interface.  Case in point, winmodems & nvidia.  But the question is if we
really want to encourage binary-only modules, which most in the community
don't.

In Linux, drivers are kernel modules, and that has the ability to completly
hose the rest of the kernel if there are bugs in the module.  You won't get
around this with a static binary interface unless you put a lot of overhead
and layering between a module and the kernel.  Right now, once a module is
loaded, it IS now part of the kernel.

> Like it or not, 99+% of 
> 'potential users' don't want/need to recompile their whole kernel, with the
> risks that it has, to add one minor feature.

And they don't.  If they don't know how, or don't want to, they should be
using a distribution kernel that does it for them.

Are you saying that you want to add or change something now that is not
modularized yet?

If so what and how?  Yes you can say with this nice binary interface you can
add whatever feature you want with a nice new driver.  Well, you can do that
now.  All you have to do is compile against the source of the kernel you're
running, and you can insert it into the kernel without rebooting.

And if you're trying to change something in a running kernel that isn't a
module you can unload (so the root filesystem is out at the very least),
then you're talking about an entirely new can of worms.
