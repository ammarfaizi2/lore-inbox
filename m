Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbUDNGNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263908AbUDNGNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:13:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263905AbUDNGN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:13:29 -0400
Date: Wed, 14 Apr 2004 02:12:55 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mq_open() and close_on_exec?
Message-ID: <20040414061255.GA31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040413174005.Q22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413174005.Q22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 05:40:05PM -0700, Chris Wright wrote:
> SUSv3 doesn't seem to specify one way or the other.  I don't have the
> POSIX specs, and the old docs I have suggest that mq_open() creates an
> object which is to be closed upon exec.  Anyone have a clue if this is
> actually required?  Patch below sets this as default (if indeed it's
> valid/required).

I think it is valid and required:
http://www.opengroup.org/onlinepubs/007904975/functions/exec.html

^[MSG] [Option Start] All open message queue descriptors in the calling process shall be closed, as described in
mq_close() . [Option End]

I'll add a new test for this into glibc testsuite.

	Jakub
