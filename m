Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVCIPGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVCIPGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCIPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:06:12 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54168 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261748AbVCIPGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:06:10 -0500
Date: Wed, 9 Mar 2005 20:36:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       gdb <gdb@sources.redhat.com>, Dave Anderson <anderson@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
Message-ID: <20050309150644.GA4663@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com> <m1br9um313.fsf@ebiederm.dsl.xmission.com> <1110350629.31878.7.camel@wks126478wss.in.ibm.com> <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 07:17:49AM -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Tue, 2005-03-08 at 11:00 -0700, Eric W. Biederman wrote: 
> > 
> > This also requires, setting the kernel virtual addresses while preparing
> > the headers. KVA for linearly mapped region is known in advance and can
> > be filled at header creation time and gdb can directly operate upon this
> > region.
> 
> I have no problems decorating the ELF header you are generating
> in user space with virtual addresses assuming we can reliably
> get that information.  And before a kernel crashes looks like a reasonable
> time to ask that question.  I don't currently see where you could
> derive that information.
> 
> Beyond that I prefer a little command line tool that will do the
> ELF64 to ELF32 conversion and possibly add in the kva mapping to
> make the core dump usable with gdb.  Doing it in a separate tool
> means it is the developer who is doing the analysis who cares
> not the user who is capturing the system core dump.

Well, as a kernel developer, I am both :) For me, having to install
half-a-dozen different command line tools to get and analyze a crash dump
is a PITA, not to mention potential version mismatches. As someone
who would like very much to use crash dump for debugging, I would
much rather be able to force a dump and then use gdb for
a quick debug. I agree that a customer would see a different
situation. It would be nice if we can cater to both the kinds.

Thanks
Dipankar
