Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBDAXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBDAXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVBDAXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:23:51 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:51860 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261778AbVBDAXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:23:43 -0500
Date: Fri, 04 Feb 2005 09:23:47 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m1fz0f9g20.fsf@ebiederm.dsl.xmission.com>
References: <20050202161108.18D7.ODA@valinux.co.jp> <m1fz0f9g20.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050204090151.18F0.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02 Feb 2005 07:45:11 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> And the feedback begins :)
> 
> Itsuro Oda <oda@valinux.co.jp> writes:
> 
> > Hi,
> > 
> > I don't like calling crash_kexec() directly in (ex.) panic().
> > It should be call_dump_hook() (or something like this).
> > 
> > I think the necessary modifications of the kernel is only:
> > - insert the hooks that calls a dump function when crash occur
> crash_kexec()
> > - binding interface that binds a dump function to the hook
> >   (like register_dump_hook())
> sys_kexec_load(...);

For example there are pepole who want to execute a built in kernel
debugger when the system is crashed. or there are pepole who
believe the diskdump is the best dump tool :-)

So I think a sort of hook is better than calling crash_kexec 
directly. (May I make a patch ?)

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

