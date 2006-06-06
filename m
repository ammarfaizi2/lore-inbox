Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWFFLHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWFFLHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWFFLHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:07:23 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:12416 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751172AbWFFLHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:07:22 -0400
Date: Tue, 6 Jun 2006 20:08:37 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: Preben Traerup <Preben.Trarup@ericsson.com>
Cc: ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, vgoyal@in.ibm.com
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-Id: <20060606200837.3ad723c0.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <44854C8D.6040707@ericsson.com>
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
	<44800E1A.1080306@ericsson.com>
	<m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
	<44803B1F.8070302@ericsson.com>
	<m13ben60tn.fsf@ebiederm.dsl.xmission.com>
	<44854C8D.6040707@ericsson.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 11:36:13 +0200
Preben Traerup <Preben.Trarup@ericsson.com> wrote:

> Eric W. Biederman wrote:
> 
> >Preben Traerup <Preben.Trarup@ericsson.com> writes:
> >
> >  
> >
> >  
> >
> >>Since I'm apperantly not the only one left with this choice I rather prefer a
> >>solution
> >>made in public, that is known to be "bad" in some (well known) situations than
> >>each and everybody implements their own solution to the same problem.
> >>    
> >>
> >
> >It is certainly worth discussing.
> >
> >Eric
> >
> >  
> >
> To handle the contradiction of adding crash notifier to kexec and 
> maintaining kexec reliability
> I suggest adding a flag to Kconfig
> ENABLE_CRASH_NOTIFIER
> 
> This removes any code in the critical path for people not needing crash 
> notification.

I am just thinking same thing, but one point is different.
To select policy by Kconfig is not flexible. If we want to change policy,
we have to rebuild the kernel. I don't think that distributors release
the kernels for each policy.

Instead of Kconfig, how about using proc filesystem. e.g. kdump_safe.
If kdump_safe is 1, crash notifier will not be called.
If kdump_safe is 0, crash notifier will be called.  

Regards,

Akiyama, Nobuyuki

