Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbTISKds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTISK2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:28:49 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:11654 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S261515AbTISK1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:27:23 -0400
Date: Fri, 19 Sep 2003 22:27:40 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Resuming from software suspend
In-reply-to: <yw1xoexhkrtb.fsf@users.sourceforge.net>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1063967259.7874.14.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <1063915370.2410.12.camel@laptop-linux>
 <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux>
 <yw1xu179mc55.fsf@users.sourceforge.net>
 <1063963914.7253.9.camel@laptop-linux>
 <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net>
 <1063965939.7874.6.camel@laptop-linux> <yw1xoexhkrtb.fsf@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provided you're not making the data of the filesystem inconsistent with
the state that the suspended image is expecting to see, you won't get
any corruption. As to beginning a resume without rebooting, whether it
would work would depend upon the size of the image, the amount of memory
used when you start the resume and the degree of overlap between the two
sets of memory.

Regards,

Nigel

On Fri, 2003-09-19 at 22:15, Måns Rullgård wrote:
> Nigel Cunningham <ncunningham@clear.net.nz> writes:
> 
> > If your filesystems were mounted readonly and the boot won't mount them
> > writable, you should be fine with no special precautions. Last time I
> > looked at 2.6 code, it didn't fix the suspend header when you use
> > noresume. If that's still true, you should be able to boot with the
> > noresume option, and then later normally.
> 
> What I want to do is boot, do some things, and then resume the
> suspended state without rebooting between.  Is that possible?  I don't
> see any reason why it should be impossible to do, even if it's not
> currently supported.
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

