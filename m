Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWCAXk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWCAXk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWCAXk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:40:57 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31469 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751953AbWCAXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:40:56 -0500
Date: Wed, 1 Mar 2006 15:40:40 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, greg@kroah.com, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, yanmin.zhang@intel.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301154040.a7cb2afd.pj@sgi.com>
In-Reply-To: <20060301151000.5fff8ec5.pj@sgi.com>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> But Paul bisected it down to a particular not-merged patch,
> gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch, which I'll
> admit doesn't look like it'll cause this.

Verified.

Also ...

  1) As stated before, this is -only- with CONFIG_DEBUG_SPINLOCK and
     CONFIG_DEBUG_SPINLOCK_SLEEP enabled.  If I turn these two off,
     it boots fine.

  2) Because the patch:
	gregkh-driver-put_device-might_sleep.patch
     that comes just before here was causing me to worry with its
     added error messages, I removed it from my stack.  That made
     no difference to the failing boot (it simply removed the
     error messages, as Greg would predict.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
