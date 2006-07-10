Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422702AbWGJUKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbWGJUKA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbWGJUKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:10:00 -0400
Received: from old-tantale.fifi.org ([64.81.251.130]:56973 "EHLO
	tantale.fifi.org") by vger.kernel.org with ESMTP id S1422702AbWGJUJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:09:59 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
References: <44B0FAD5.7050002@argo.co.il>
	<MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>
	<20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com>
	<20060710034250.GA15138@thunk.org>
	<bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
	<20060710185435.GA5445@ccure.user-mode-linux.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 10 Jul 2006 13:09:47 -0700
In-Reply-To: <20060710185435.GA5445@ccure.user-mode-linux.org>
Message-ID: <874pxp1at0.fsf@tantale.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> On Mon, Jul 10, 2006 at 10:00:37AM -0700, Joshua Hudson wrote:
> > Yes, I use vfork. So far, the only way I have found for the parent to
> > know whether or not the child's exec() failed is this way:
> 
> What I do in UML is make a pipe between the parent and child, set it
> CLOEXEC, and write a byte down it if the exec fails.
> 
> The parent reads it - if it gets no bytes, the exec succeeded, if it
> gets one byte, it failed.

I usually do the same, except that I write the errno in case of
failure.  This way the parent knows *why* exec failed ;-)

Phil.

