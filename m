Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWH1FOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWH1FOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWH1FOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:14:15 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:50551 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932355AbWH1FOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:14:14 -0400
Date: Sun, 27 Aug 2006 22:14:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
Message-ID: <20060828051409.GA17891@tuatara.stupidest.org>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <17650.13915.413019.784343@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17650.13915.413019.784343@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 10:18:35AM +1000, Paul Mackerras wrote:

> I believe the reason for not doing something like this on x86 was
> the fact that we still support i386 processors, which don't have the
> cmpxchg instruction.  That's fair enough, but I would be opposed to
> making semaphores bigger and slower on PowerPC because of that.
> Hence the two different styles of implementation.

The i386 is older than some of the kernel hackers, and given that a
modern kernel is pretty painful with less than say 16MB or RAM in
practice, I don't see that it would be all that terrible to drop
support for ancient CPUs at some point (yes, I know some newer
embedded (and similar) CPUs might be affected here too, but surely not
that many that people really use --- and they could just use 2.4.x).
