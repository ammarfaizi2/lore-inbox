Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264332AbUDTXfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbUDTXfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUDTXet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:34:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:4746 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263789AbUDTXcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:32:50 -0400
Date: Tue, 20 Apr 2004 16:34:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: manfred@colorfullife.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-Id: <20040420163443.7347da48.akpm@osdl.org>
In-Reply-To: <20040420231351.GB13826@logos.cnet>
References: <20040419212810.GB10956@logos.cnet>
	<20040419224940.GY31589@devserv.devel.redhat.com>
	<20040420141319.GB13259@logos.cnet>
	<20040420130439.23fae566.akpm@osdl.org>
	<20040420231351.GB13826@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > The major advantage of your work is that we can now remove those limits. 
> > You'll be needing a 2.4 backport ;)
> 
> Yeap. :) 
> 
> And we also need to do the userspace part. ulimit is part of bash, so 
> probably all shell's should be awared of this? I never looked
> how "ulimit" utility works.

yup, the shells need to be changed, which is really awkward.  I was wrong
about how bash and zsh handle `ulimit 4 1024'.

Really the shells _should_ permit ulimit-by-number for this very reason.

Adding new ulimits is nice - it's a shame that the shells make it hard to
use.
