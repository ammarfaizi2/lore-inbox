Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWIIFZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWIIFZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWIIFZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:25:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42183 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932148AbWIIFZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:25:10 -0400
Date: Fri, 8 Sep 2006 22:21:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Brandon Philips <brandon@ifup.org>, linux-kernel@vger.kernel.org,
       Brice Goglin <brice@myri.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
Message-Id: <20060908222141.564e3b2a.akpm@osdl.org>
In-Reply-To: <m1slj1iurx.fsf@ebiederm.dsl.xmission.com>
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
	<20060908125053.c31b76e9.akpm@osdl.org>
	<m1slj1iurx.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2006 21:27:46 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Fri, 8 Sep 2006 14:43:00 -0500
> > Brandon Philips <brandon@ifup.org> wrote:
> >
> >> On 12:13 Fri 08 Sep 2006, Andrew Morton wrote:
> >> > On Fri, 8 Sep 2006 12:44:37 -0500
> >> > Brandon Philips <brandon@ifup.org> wrote:
> >> > > 2.6.18-rc4-mm3 boots ok.
> >> > > 
> >> > > I will try and bisect the problem later tonight-
> >> > 
> >> > Thanks.  First, try disabling CONFIG_PCI_MSI.
> >> 
> >> With CONFIG_PCI_MSI disabled the system boots.  
> >
> > OK, thanks.
> >
> > So likely candidates are:
> >
> > - Brice's MSI changes
> >
> > - The conversion of i386 to use the genirq code
> >
> > - Eric's MSI/genirq changes
> >
> > or a combination of the above.  Or something else.
> >
> > <adds ccs, steps back expectantly>
> 
> Thanks for the heads up.
> 
> There was another panic reported last -mm tree I believe as well.
> 

Yes, there were a couple such reports.  The MSI patches in Greg's tree were
blamed and rc6-mm1 has a revamped version.  Whether they were sufficiently
revamped we do not know.

