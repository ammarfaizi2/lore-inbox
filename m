Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTKRQFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTKRQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:05:16 -0500
Received: from ns.suse.de ([195.135.220.2]:12214 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263662AbTKRQFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:05:12 -0500
Date: Tue, 18 Nov 2003 17:05:09 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
Message-Id: <20031118170509.71bfb039.ak@suse.de>
In-Reply-To: <20031118154921.GA28942@mail.shareable.org>
References: <1068512710.722.161.camel@cube.suse.lists.linux.kernel>
	<20031111133859.GA11115@bitwizard.nl.suse.lists.linux.kernel>
	<20031111085323.M8854@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<bp0p5m$lke$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<20031113233915.GO1649@x30.random.suse.lists.linux.kernel>
	<3FB4238A.40605@zytor.com.suse.lists.linux.kernel>
	<20031114011009.GP1649@x30.random.suse.lists.linux.kernel>
	<3FB42CC4.9030009@zytor.com.suse.lists.linux.kernel>
	<p734qx7rmyf.fsf@oldwotan.suse.de>
	<20031118154921.GA28942@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003 15:49:21 +0000
Jamie Lokier <jamie@shareable.org> wrote:

> Andi Kleen wrote:
> > > s/EINTR/short count/, of course :)
> > 
> > That would be buggy because existing users of sendfile don't know
> > about this and would silently only copy part of the file when a signal
> > happens.
> 
> That doesn't make sense.  There aren't any existing users of sendfile
> to copy files.

[ignore the mail, it was an stuck mail queue]

But note that arbitary changes in the signal handling would affect all users of sendfile, not just 
those that attempt to copy files or do other things that should be done in user space.

-Andi
