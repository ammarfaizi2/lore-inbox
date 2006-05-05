Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWEEMR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWEEMR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 08:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWEEMR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 08:17:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:12996 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751048AbWEEMR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 08:17:58 -0400
Date: Fri, 5 May 2006 07:17:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060505121754.GE12850@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <200605021017.19897.ak@suse.de> <20060502172031.GA22923@sergelap.austin.ibm.com> <200605021930.45068.ak@suse.de> <20060503161143.GA18576@sergelap.austin.ibm.com> <20060505064445.GA3437@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505064445.GA3437@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Herbert Poetzl (herbert@13thfloor.at):
> On Wed, May 03, 2006 at 11:11:43AM -0500, Serge E. Hallyn wrote:
> > Should we talk about this  on irc someplace?  Perhaps drag in Eric as
> > well?
> 
> good idea, feel free to use #vserver (irc.oftc.net) for that

Moves a bit too fast for me to be able to keep up, but I'll try to hang
out there more than I have been  :)

> > Anyway I guess I'll go ahead and queue up some tests.
> 
> good!

As I later mentioned, this won't necessary give honest picture of
performance implications, since some namespaces might need to be
frequently referenced, in which case the extra indirection from
task_struct->container->nsstruct may give a big hit.

But perhaps I can use the utsname ns on top of the experimental
container patch to test that aspect.

thanks,
-serge
