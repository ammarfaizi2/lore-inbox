Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbUKYGq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbUKYGq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 01:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbUKYGq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 01:46:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:19079 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262980AbUKYGqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:46:54 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend/resume ceased to work with 2.4.28
References: <87zn1amuov.fsf@ceramic.fifi.org>
	<20041122173654.GA31848@logos.cnet> <87mzx94ekm.fsf@ceramic.fifi.org>
	<20041123070252.GA2712@logos.cnet>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 24 Nov 2004 22:10:54 -0800
Message-ID: <871xeia26p.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> On Mon, Nov 22, 2004 at 04:03:05PM -0800, Philippe Troin wrote:
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> > 
> > > On Sun, Nov 21, 2004 at 07:25:20PM -0800, Philippe Troin wrote:
> > > > Seen on a Dell Inspiron 3800 with BIOS revision A17.
> > > > 
> > > > APM suspend/resume works perfectly with 2.4.27 (or at least, as well
> > > > as APM can).
> > > > 
> > > > Since I did not see any differences in arch/i386/kernel/apm.c between
> > > > .27 and .28, I'm at loss to explain the problem.
> > > 
> > > Guess: Are you using ACPI ? 
> > 
> > ACPI is compiled in, but the kernel is booted with noacpi...
> > 
> > Phil.
> 
> Phil, 
> 
> Can you please try 2.4.28-pre3 ? 
> 
> Lets try to find out where it started to happen. I've got no clue, 
> there are no indeed no APM related changes in 2.4.28.

The bug was introduced between rc1 and rc2.

I'm still working on it to narrow it down to which delta introduced
the bug.

I suspect either the ACPI or the APIC/DMI changes.

Phil.
