Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269832AbUIDIPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269832AbUIDIPa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269833AbUIDIPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:15:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:32991 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269832AbUIDIP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:15:28 -0400
Date: Sat, 4 Sep 2004 10:14:51 +0200
From: Greg KH <greg@kroah.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040904081451.GB21430@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <1094004324.1916.63.camel@localhost.localdomain> <20040901100750.GA23337@vrfy.org> <1094157902.1316.83.camel@DYN319498.beaverton.ibm.com> <1094163351.26430.107.camel@localhost.localdomain> <1094255991.1315.34.camel@DYN319498.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094255991.1315.34.camel@DYN319498.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 04:59:51PM -0700, Daniel Stekloff wrote:
> On Thu, 2004-09-02 at 15:15, Kay Sievers wrote:
> [snip]
> > Maybe we just need to rename "kevent" to "kobject_notify" to make the
> > focus more clear :)
> 
> 
> Thanks, Kay, for answering my questions. 
> 
> I'm wondering if you've narrowed the interface too much in respect to
> possible events. I'm interested in error event notification.

I don't think this "event notification" system should be used for error
event notification.  For errors, you want to never drop them, or want to
rely on userspace reading the sysfs attribute file in time before it
changes again.

And as my previous message shows, I think we just evolved back to the
current hotplug interface, which really isn't a good one for errors :)

> If you curious about the error events, I've started a list of actionable
> error events that includes the current message string, possible causes,
> and possible actions (it's a work in progress):
> 
> http://linux-diag.sourceforge.net/first_failure/FirstFailure.html

That's a great start.  Hopefully it will help in figuring out what error
messages should be standardized on across drivers that belong to the
same class.

thanks,

greg k-h
