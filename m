Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbULPOZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbULPOZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbULPOZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:25:26 -0500
Received: from news.suse.de ([195.135.220.2]:57259 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262666AbULPOWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:22:02 -0500
Date: Thu, 16 Dec 2004 15:21:56 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041216142156.GB29761@wotan.suse.de>
References: <20041215114916.GB1232@elf.ucw.cz> <E1CekDZ-0005ZY-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CekDZ-0005ZY-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 01:14:09AM +0000, Ian Pratt wrote:
> The other key area is that our top priority is to decrease the
> number of files we need to modified from standard i386. For this
> to happen, we need to submit patches into i386 that abstract a
> few things behind macros/constants. For example, we'd like to
> abstract the test to see whether the CPU is in the kernel or not
> (we run the kernel in ring 1 rather than 0).  If arch xen is in
> the tree, this kind of patch will make rather more sense to
> people.

That would be a good first step, especially if it results in cleanups.
Please go for it.

> I don't see it like that. While continuing to track changes in
> i386/x86_64, we'd restructure the code under arch xen such that
> it could build (or even boot) time switch between running native
> and over Xen. At some point the arch directory could then be
> renamed.  This would be a big project, and one that would involve

This sounds like a massive duplication of effort. You would need
to do all that work on arch/xen and in parallel on the native
port for the slow merge, and in parallel track a changing target
and keep the code usable in mainline.

-Andi
