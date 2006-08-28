Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWH1FV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWH1FV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWH1FV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:21:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25020 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932350AbWH1FV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:21:27 -0400
Date: Sun, 27 Aug 2006 22:21:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Paul Mackerras <paulus@samba.org>, Dong Feng <middle.fengdong@gmail.com>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <20060828051409.GA17891@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.64.0608272220470.24098@schroedinger.engr.sgi.com>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <17650.13915.413019.784343@cargo.ozlabs.ibm.com> <20060828051409.GA17891@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006, Chris Wedgwood wrote:

> On Mon, Aug 28, 2006 at 10:18:35AM +1000, Paul Mackerras wrote:
> 
> > I believe the reason for not doing something like this on x86 was
> > the fact that we still support i386 processors, which don't have the
> > cmpxchg instruction.  That's fair enough, but I would be opposed to
> > making semaphores bigger and slower on PowerPC because of that.
> > Hence the two different styles of implementation.
> 
> The i386 is older than some of the kernel hackers, and given that a
> modern kernel is pretty painful with less than say 16MB or RAM in
> practice, I don't see that it would be all that terrible to drop
> support for ancient CPUs at some point (yes, I know some newer
> embedded (and similar) CPUs might be affected here too, but surely not
> that many that people really use --- and they could just use 2.4.x).

Also note that i386 has a cmpxchg emulation for those machines that do not 
support cmpxchg.

