Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268979AbUH3S1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268979AbUH3S1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268838AbUH3SZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:25:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8135 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268711AbUH3SEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:04:37 -0400
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
References: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
	<m1u0uu2d4b.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58L.0408252118150.18088@blysk.ds.pg.gda.pl>
	<m1vff6vhyi.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58L.0408301437260.12806@blysk.ds.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Aug 2004 12:02:50 -0600
In-Reply-To: <Pine.LNX.4.58L.0408301437260.12806@blysk.ds.pg.gda.pl>
Message-ID: <m14qmkfqr9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Thu, 25 Aug 2004, Eric W. Biederman wrote:
> 
> > I don't think the configuration you are worrying about where
> > both the ioapic and the local apic can both be put into virtual
> > wire mode is valid according to the mp specification.  Although that
> > is probably a grey area in the specification.
> 
>  The spec doesn't preclude a configuration where the master i8259A is
> wired both to an I/O APIC input and to local APIC inputs.  If this is the
> case, it's a sole discretion of the system manufacturer to choose which
> route for the "virtual wire" is used.
> 
>  I don't insist on doing exact LVT restoration as at this stage it
> shouldn't really matter and the firmware should reinitialize the APIC
> subsystem completely anyway.  I just wanted to be sure you are aware of
> the issue.

Thanks. I will keep it in mind.

Actually now that I think about it I believe recent Intel chipsets
Tumwater/Lindenhurst work both ways but they have a bug that can
be triggered unless you are using the IOAPIC in virtual wire
mode.

In practice I still don't think it matters as everything across the
hub interface and PCI-e is message based and I don't think 2 messages
are generated.  Still I will give it some thought.

Eric


