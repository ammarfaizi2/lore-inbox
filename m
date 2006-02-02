Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWBBWN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWBBWN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBBWN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:13:28 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:33975 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932313AbWBBWN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:13:27 -0500
Date: Thu, 2 Feb 2006 17:08:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Wanted: hotfixes for -mm kernels
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602021710_MC3-1-B771-3DDC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1138913633.15691.109.camel@mindpipe>

On Thu, 02 Feb 2006 at 15:53:52 -0500, Lee Revell wrote:

> On Thu, 2006-02-02 at 15:00 -0500, Chuck Ebbert wrote:
> > Most -mm kernels have small but critical bugs that are found shortly
> > after release.  Patches for these are posted on linux-kernel but
> > they aren't made available on kernel.org until the next -mm release.
> > 
> > Would it be possible to create a hotfix/ directory for each -mm
> > release and put those patches there?  A README could explain that
> > the fixes are untested.  At least people reading the files could
> > see an issue exists even if they're not brave enough to try the
> > patch. :)
>
> I doubt it - mm is an experimental kernel, hotfixes only make sense for
> production stuff.  It moves too fast.
>
> A better question is what does -mm give you that mainline does not, that
> causes you to want to "stabilize" a specific -mm version?

I'm talking about patches for problems that keep you from even testing
-mm, or that fix really annoying things you hit while testing.

E.g. in 2.6.16-rc1-mm4 we have:

        - SMP alternatives removes the lock prefix from instructions
          in every loaded module because it wrongly believes you are
          running an SMP kernel on UP.

        - Device-mapper mirroring is using the wrong endianness and will
          try to recover non-existent regions on the device.

        - Compiler spews hundreds of warning messages during build.

        - VGA console scrollback is totally broken because it prints
          a message on every scroll operation.

Patches for all of the above and more have been posted to the list and
I have applied them.  All I want is a place to collect them so they can
be more easily found.
-- 
Chuck

