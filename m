Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTKRNsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTKRNmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:38 -0500
Received: from ns.suse.de ([195.135.220.2]:63953 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262709AbTKRNmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:18 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube.suse.lists.linux.kernel>
	<20031111133859.GA11115@bitwizard.nl.suse.lists.linux.kernel>
	<20031111085323.M8854@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<bp0p5m$lke$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<20031113233915.GO1649@x30.random.suse.lists.linux.kernel>
	<3FB4238A.40605@zytor.com.suse.lists.linux.kernel>
	<20031114011009.GP1649@x30.random.suse.lists.linux.kernel>
	<3FB42CC4.9030009@zytor.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Nov 2003 16:26:00 +0100
In-Reply-To: <3FB42CC4.9030009@zytor.com.suse.lists.linux.kernel>
Message-ID: <p734qx7rmyf.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Andrea Arcangeli wrote:
> > On Thu, Nov 13, 2003 at 04:36:26PM -0800, H. Peter Anvin wrote:
> > 
> >>... or we could put in checks into the kernel for signal pending, and
> >>return EINTR.
> > 
> > that would be even better indeed.
> >
> 
> s/EINTR/short count/, of course :)

That would be buggy because existing users of sendfile don't know
about this and would silently only copy part of the file when a signal
happens.

-Andi
