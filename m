Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267790AbUG2PyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267790AbUG2PyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUG2Pwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:52:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19643 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268213AbUG2PsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:48:14 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	<200407281106.17626.jbarnes@engr.sgi.com>
	<20040728124405.1a934bec.akpm@osdl.org>
	<m1pt6f681y.fsf@ebiederm.dsl.xmission.com>
	<1091055192.31923.1.camel@localhost.localdomain>
	<m14qnr62hd.fsf@ebiederm.dsl.xmission.com>
	<1091109602.851.4.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2004 09:47:01 -0600
In-Reply-To: <1091109602.851.4.camel@localhost.localdomain>
Message-ID: <m1zn5ike8a.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2004-07-29 at 02:12, Eric W. Biederman wrote:
> > Or those devices that hang the machine when you clear it.
> 
> There are none. Its required by the PCI spec and used by BIOS vendors
> during the boot sequence. So its a *tested* approach.

Enabling is required.  Clearing is not.  The particular instance I was
thinking of was disabling memory access and leaving I/O enabled.  
 
> > And there is the fact that the pci configuration access methods
> > are frequently BIOS calls.
> 
> You will be running bios code on some systems every time you read
> the cmos clock, every time you touch pci config space, every time
> you hit a key, even in your new kernel boot up path - whats your
> point

Only that in many instances BIOS code can do things we don't expect.
And when we start out with the machine in an unknown state the
risk is worse.

> > So I do see just clearing the master bit on each PCI devices to
> > as dangerous as calling the shutdown methods.
> 
> Then we violently disagree

yes.

Eric
