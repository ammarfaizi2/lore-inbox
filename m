Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTISJbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 05:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTISJbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 05:31:38 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:56539 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261440AbTISJbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 05:31:37 -0400
Date: Fri, 19 Sep 2003 21:31:54 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: How does one get paid to work on the kernel?
In-reply-to: <yw1xu179mc55.fsf@users.sourceforge.net>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1063963914.7253.9.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <1063915370.2410.12.camel@laptop-linux>
 <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux> <yw1xu179mc55.fsf@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, provided as you say that you don't mount the file systems involved;
mounting them will make journalling filesystems run their recoveries,
which will in turn make the suspend image inconsistent. It's only really
viable if the filesystems were mounted read only to start with... I've
just added functionality to the 2.4 version for such a case.

Regards,

Nigel

On Fri, 2003-09-19 at 20:10, Måns Rullgård wrote:
> Nigel Cunningham <ncunningham@clear.net.nz> writes:
> 
> > There is support in the current kernel for Software Suspend, but the 2.4
> > version contains a lot of extra functionality that isn't present in 2.6
> > at the moment. (Support for HighMem, swap files, asynchronous I/O, a
> > nicer user interface, compression...).
> 
> I see.  BTW, is it possible to boot normally, and later resume from
> the saved state, provided you don't touch any filesystems or swap
> areas involved in the suspend?  I seem to recall reading somewhere
> that it would be possible, but I can't find any information on how to
> do it.
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

