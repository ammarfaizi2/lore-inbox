Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVKMLAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVKMLAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 06:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVKMLAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 06:00:15 -0500
Received: from mail.suse.de ([195.135.220.2]:16863 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932428AbVKMLAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 06:00:14 -0500
To: Dave Jones <davej@redhat.com>
Cc: Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	<20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	<Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	<4374FB89.6000304@vmware.com>
	<Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	<20051113074241.GA29796@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 11:59:55 +0100
In-Reply-To: <20051113074241.GA29796@redhat.com>
Message-ID: <p734q6g4xuc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:
> 
> Looks like the Ubuntu people already did this...
> 
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=048985336e32efe665cddd348e92e4a4a5351415;hp=1cb630c2b5aaad7cedaa78aa135e6cecf5ab91ac

It's probably not needed. At least AMD K7/K8 has a SYSCFG MSR bit to
do this (or rather they disable bus cycles for locks that makes them
very cheap) Intel has one too in a different MSR that looks similar.
With some luck they're even already set by the BIOS on UP systems.  I
know they are on some AMD systems.

But overall the feature doesn't help longer term because single
threaded CPUs are on their way out.

-Andi
