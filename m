Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266956AbUAXPpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266957AbUAXPpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:45:18 -0500
Received: from ns.suse.de ([195.135.220.2]:9152 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266956AbUAXPpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:45:12 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: ivi@runbox.com, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.1 + XFS wierdness
References: <8D2C6B0D-21C8-11B2-9DDD-000A958B60EE__36670.0378632688$1074934610@runbox.com.suse.lists.linux.kernel>
	<yw1xhdyl7jf6.fsf@ford.guide.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Jan 2004 16:45:10 +0100
In-Reply-To: <yw1xhdyl7jf6.fsf@ford.guide.suse.lists.linux.kernel>
Message-ID: <p737jzhfj09.fsf@wotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> Igor <ivi@runbox.com> writes:
> 
> > Ok, as advised I'm reporting what happened to my system:
> > I run Kernel 2.6.1 with XFS on a laptop, I forgot to send it to "sleep"
> > and battery died, so there was unclean unmount (This is, what I
> > believe was the cause),
> > at some point after I restarted my system many of the files couldn't
> > be executed:
> > "binary file can't be executed reported", However the system was
> > functional and I could boot it.
> > So I hexopened some of the problematic files and found that although
> > the size of the file is maintained, there was no data, every byte was
> > replaced by 0, I guess it was lucking reference on a hard drive or
> > maybe something else. The reason I think the root of the problem is
> > filesystem + kernel because the "corrupted" files have nothing in
> > common, e.g:
> > /usr/bin/file
> > /etc/init.d/cron
> > /usr/bin/lynx
> > and that only happened when I updated kernel to 2.6.1
> 
> See http://oss.sgi.com/projects/xfs/faq.html#nulls

I don't think his description fits the FAQ.
The XFS 0 problem should only happen to files that have been written
shortly before the crash.
Zeroing/destroying random files that haven't been written looks more like a 
bug (either in XFS or in a driver) 

-Andi
 
