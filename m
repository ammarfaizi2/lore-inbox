Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUH3Mn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUH3Mn5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUH3Mn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:43:57 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:14855 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267881AbUH3Mnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:43:55 -0400
Date: Mon, 30 Aug 2004 14:43:51 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
In-Reply-To: <m1vff6vhyi.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58L.0408301437260.12806@blysk.ds.pg.gda.pl>
References: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
 <m1u0uu2d4b.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58L.0408252118150.18088@blysk.ds.pg.gda.pl>
 <m1vff6vhyi.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2004, Eric W. Biederman wrote:

> I don't think the configuration you are worrying about where
> both the ioapic and the local apic can both be put into virtual
> wire mode is valid according to the mp specification.  Although that
> is probably a grey area in the specification.

 The spec doesn't preclude a configuration where the master i8259A is
wired both to an I/O APIC input and to local APIC inputs.  If this is the
case, it's a sole discretion of the system manufacturer to choose which
route for the "virtual wire" is used.

 I don't insist on doing exact LVT restoration as at this stage it
shouldn't really matter and the firmware should reinitialize the APIC
subsystem completely anyway.  I just wanted to be sure you are aware of
the issue.

  Maciej
