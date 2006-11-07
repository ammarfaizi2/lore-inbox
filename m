Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752626AbWKGVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbWKGVBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbWKGVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:01:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:54220 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752626AbWKGVBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:01:45 -0500
Date: Tue, 7 Nov 2006 13:01:44 -0800 (PST)
From: Dave Olson <olson@pathscale.com>
Reply-To: olson@pathscale.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
In-Reply-To: <m1wt677zgr.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0611071258220.8122@topaz.pathscale.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061105064801.GV13381@stusta.de> <m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
 <20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
 <m1psbzbpxw.fsf@ebiederm.dsl.xmission.com> <4550B22C.1060307@serpentine.com>
 <m18xinb1qn.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611070934570.25925@topaz.pathscale.com>
 <m1mz739l0b.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611071228230.8122@topaz.pathscale.com>
 <m1wt677zgr.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Eric W. Biederman wrote:
| > Displaying something that might change is a fact of life, and no
| > different than the PCI world.  It's still best to keep things as
| > correct as possible.
| 
| No.  I was thinking of the rat hole in pci config space you have to
| access to read these registers.  You have to actively write a pci
| config value to select which register you are going to read.
| 
| So by default it is not safe to touch this value from user space,
| because you could mess up the kernel, if the kernel is updating the
| value.

Nonetheless, as root, lspci already does that (it displays the MSI
interrupt info).  I  wasn't talking about fixing that, just saying
that having the data being as correct as possible, is highly
desirable.   We can't know everything that everybody is doing with
the data.

Improvements in the pciutils library and locking with respect to the
kernel may well be desirable, but are an independent issue from
correctness.

Dave Olson
dave.olson@qlogic.com
