Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWFBPhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWFBPhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFBPhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:37:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50865 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932406AbWFBPhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:37:23 -0400
Date: Fri, 2 Jun 2006 11:37:17 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Preben Traerup <Preben.Trarup@ericsson.com>,
       "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-ID: <20060602153717.GC29610@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060530145658.GC6536@in.ibm.com> <20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com> <20060531154322.GA8475@in.ibm.com> <20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com> <20060601151605.GA7380@in.ibm.com> <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com> <44800E1A.1080306@ericsson.com> <m1fyin6agv.fsf@ebiederm.dsl.xmission.com> <44803B1F.8070302@ericsson.com> <m13ben60tn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13ben60tn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 09:20:52AM -0600, Eric W. Biederman wrote:
> Preben Traerup <Preben.Trarup@ericsson.com> writes:
> 
> > Something like out of memory and oops-es are enough to deeme the system must
> > panic
> > because it is simply not supposed to happen in a Telco server at any time.
> 
> That is clearly enough to deem that the system must take some sever action and
> stop running.  You don't necessarily have to handle it through a kernel panic.
> 
> > kdump helps debugging these cases, but more importantly another server
> > must take over the work, and this has and always will have highest priority.
> >
> > I'm happy about what crash_kexec does today, but the timing issue makes it
> > unusable for
> > notifications to external systems, if I need to wait until properly running in
> > next kernel.
> 
> Nothing says you have to wait until properly running in the next kernel.
> You can also write a dedicated piece of code that just pushes one packet
> out the NIC.  Then you can start up a kernel for analysis purposes.
> 

So basically the idea is that whatever one wants to do it should be done
in the next kernel, even notifications. But this might require some data
from the context of previous kernel, for example destination IP address etc.
So the associated data either needs to be passed to new kernel or it shall
have to be retrieved from permanent storage or something like that.

Thanks
Vivek
