Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269715AbUJAGpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269715AbUJAGpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 02:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269719AbUJAGpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 02:45:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9119 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269715AbUJAGpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 02:45:47 -0400
Date: Thu, 30 Sep 2004 23:44:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] inotify: make user visible types portable
Message-Id: <20040930234436.097e6dfe.pj@sgi.com>
In-Reply-To: <1096608925.4803.2.camel@localhost>
References: <1096410792.4365.3.camel@vertex>
	<1096583108.4203.86.camel@betsy.boston.ximian.com>
	<20040930155704.16d71cec.pj@sgi.com>
	<1096608925.4803.2.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:
> The rule is to use the __foo variants for externally viewable types.
> Indeed, the examples you gave are wrapped in __KERNEL__.

I've no doubt you're right here.  But I'm a little confused.

Are you saying to use __u32 so user code can compile with these kernel
headers and see your new inotify symbols w/o polluting their name space
with the non-underscored typedef symbols?

I though such use of kernel headers in compiling user code was
deprecated.  I'd have figured this meant while we might not go out of
way to break someone already doing it, we wouldn't make any effort, or
tolerate any ugly as sin __foo names, in order to add to the list of
symbols so accessible.

If you have a few minutes more patience, perhaps you could explain
where my understanding departed from reality.

Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
