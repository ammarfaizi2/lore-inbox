Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTISKF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTISKF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:05:28 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:23989 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261468AbTISKFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:05:22 -0400
Date: Fri, 19 Sep 2003 22:05:39 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Resuming from software suspend [was: Re: How does one get paid	to
 work on the kernel?]
In-reply-to: <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1063965939.7874.6.camel@laptop-linux>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your filesystems were mounted readonly and the boot won't mount them
writable, you should be fine with no special precautions. Last time I
looked at 2.6 code, it didn't fix the suspend header when you use
noresume. If that's still true, you should be able to boot with the
noresume option, and then later normally.

(The 2.4 functionality I spoke of works differently, partly because it
does fix the suspend header if you use the noresume option.)

Regards,

Nigel

On Fri, 2003-09-19 at 21:45, Måns Rullgård wrote:
> Nigel Cunningham <ncunningham@clear.net.nz> writes:
> 
> > Yes, provided as you say that you don't mount the file systems involved;
> > mounting them will make journalling filesystems run their recoveries,
> > which will in turn make the suspend image inconsistent. It's only really
> > viable if the filesystems were mounted read only to start with... I've
> > just added functionality to the 2.4 version for such a case.
> 
> OK, is it possible with 2.6?  The Kconfig help says you can.  How is
> it done?
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

