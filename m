Return-Path: <linux-kernel-owner+w=401wt.eu-S932689AbWLSIvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWLSIvF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWLSIvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:51:05 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:52807 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbWLSIvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:51:04 -0500
Date: Tue, 19 Dec 2006 01:51:03 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061219085103.GK21070@parisc-linux.org>
References: <20061216080458.GC16116@elte.hu> <20061219084359.GB1731@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219084359.GB1731@ff.dom.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:43:59AM +0100, Jarek Poplawski wrote:
> I wonder why doing debug_locks_off depends here on
> debug_lock_silent state which is only "esthetical"
> flag. And debug_locks_off() takes into consideration
> debug_lock_silent after all. So IMHO:

It's not 'aesthetic' at all.  It's used to say "We are about to cause a
locking failure deliberately as part of the test suite".  It would be
wrong to disable lock debugging as a result of running the test suite.
