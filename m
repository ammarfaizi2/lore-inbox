Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUGMAIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUGMAIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUGMAIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:08:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:5590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264270AbUGMAIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:08:11 -0400
Date: Mon, 12 Jul 2004 17:06:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu, mingo@elte.hu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040712170649.6f4c0c71.akpm@osdl.org>
In-Reply-To: <200407122358.i6CNwvBD003469@localhost.localdomain>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407122358.i6CNwvBD003469@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> wrote:
>
> >resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
> >fixes ended up breaking the fs in subtle ways and I eventually gave up.
> 
> andrew, this is really helpful. should we conclude that until some
> announcement from reiser that they have addressed this, the reiserfs
> should be avoided on low latency systems?
> 

It seems that way, yes.  I do not know how common the holdoffs are in real
life.  It would be interesting if there was a user report that switching
from reiserfs to ext2/ext3 actually made a difference - this would tell us
that it is indeed a real-world problem.

Note that this info because available because someone set
/proc/asound/*/*/xrun_debug.  We need more people doing that.

