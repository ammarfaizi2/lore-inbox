Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUHRVbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUHRVbS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHRVa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:30:28 -0400
Received: from holomorphy.com ([207.189.100.168]:43961 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267746AbUHRV2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:28:31 -0400
Date: Wed, 18 Aug 2004 14:28:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert White <rwhite@casabyte.com>
Cc: "'DervishD'" <disposable1@telefonica.net>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: setproctitle
Message-ID: <20040818212824.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert White <rwhite@casabyte.com>,
	'DervishD' <disposable1@telefonica.net>,
	'Linux-kernel' <linux-kernel@vger.kernel.org>
References: <20040818085850.GW11200@holomorphy.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
> On Behalf Of William Lee Irwin III
> Sent: Wednesday, August 18, 2004 1:59 AM
> To: DervishD
> Cc: Linux-kernel
> Subject: Re: setproctitle
> > The command-line arguments are being fetched from the process address
> > space, i.e. simply editing argv[] in userspace will have the desired
> > effect. Though this code is butt ugly.

Please fix your quoting style.


On Wed, Aug 18, 2004 at 02:21:36PM -0700, Robert White wrote:
> What prevents overrun when updating arg[]?
> What happens to all the little ps (etc.) programs when I munge
> together a *really* *long* title?
> Can the entirety of arg[] be moved to a newly allocated region, if so
> how?  (e.g. wouldn't I have to have access to overwrite mm->arg_start
> etc?
> I'd prefer a setthreadtitle(char * new_title) such that the individual
> threads in a process (including the master thread, and so
> setproctitle() function is covered) could be re-titled to declare
> their purposes.  It would make debugging and logging a lot easier
> and/or more meaningful sometimes. 8-)
> It would also let the system preserve the original invocation and
> args for the lifetime of the process to prevent masquerading.  You
> know, by default the title is the args, but the set operation would
> build the new title in a new kernel-controlled place and move the
> pointer.
> I'd be willing to work on this if there is interest.

Well, I pointed the code out to you, so you should be all set to find
the answers to these questions and/or implement the proposed changes.
When you have patches for such proposed changes I'll review them then.


-- wli
