Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWC2Wva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWC2Wva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWC2Wva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:51:30 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9344 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751045AbWC2Wv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:51:29 -0500
Date: Wed, 29 Mar 2006 14:52:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Sam Vilain <sam@vilain.net>
Cc: Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060329225241.GO15997@sorel.sous-sol.org>
References: <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442B0BFE.9080709@vilain.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sam Vilain (sam@vilain.net) wrote:
> extern struct security_operations *security_ops; in
> include/linux/security.h is the global I refer to.

OK, I figured that's what you meant.  The top-level ops are similar in
nature to inode_ops in that there's not a real compelling reason to make
them per process.  The process context is (usually) available, and more
importantly, the object whose access is being mediated is readily
available with its security label.

> There is likely to be some contention there between the security folk
> who probably won't like the idea that your security module can be
> different for different processes, and the people who want to provide
> access to security modules on the systems they want to host or consolidate.

I think the current setup would work fine.  It's less likely that we'd
want a separate security module for each container than simply policy
that is container aware.

thanks,
-chris
