Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUBZJrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 04:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUBZJrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 04:47:08 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29832 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262750AbUBZJrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 04:47:05 -0500
Date: Thu, 26 Feb 2004 20:46:15 +1100
From: Nathan Scott <nathans@sgi.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
Message-ID: <20040226204615.A481868@wobbly.melbourne.sgi.com>
References: <20040225220051.GA187@schottelius.org> <20040225223428.GD640@frodo> <20040225234944.GD187@schottelius.org> <20040226032741.GB1177@frodo> <20040226082551.GA218@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040226082551.GA218@schottelius.org>; from nico-kernel@schottelius.org on Thu, Feb 26, 2004 at 09:25:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 09:25:51AM +0100, Nico Schottelius wrote:
> Nathan Scott [Thu, Feb 26, 2004 at 02:27:41PM +1100]:
> > On Thu, Feb 26, 2004 at 12:49:44AM +0100, Nico Schottelius wrote:
> > > There are still some questions open for me:
> > > 
> > > 1. why is it an internal xfs error?
> > 
> > Your loopback file seems to have got corrupted, XFS reports
> > this as an internal error (generic error message).
> 
> I am really wondering about the error message, as "internal errors" 
> indicate for me an error in the kernel.

It is a misleading error message, I'll look into correcting that.

> > > 2. why does it print a call trace?
> > 
> > XFS detected corruption, and tried to dump out some state info
> > at the point where it noticed the problem.
> 
> I am wondering how my dmesg will look like if I've to recover some
> Gigabytes of date.

The filesystem typically shuts down on detection of corruption,
so you should get just the one error report.

> And btw, do all filesystem drivers behave in this way, printing internal
> errors and displaying call traces when they find errors in the
> filesystem?

No, not all filesystem behave this way.  And it is configurable
in XFS; if you don't want this to happen, you can switch it off
via the sysctl/procfs interface - see the "error_level" section
in Documentation/filesystems/xfs.txt.

> For me this is really confusing.

Hope this helps.

cheers.

-- 
Nathan
