Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbUBZDaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUBZDaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:30:17 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1684 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262699AbUBZD3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:29:25 -0500
Date: Thu, 26 Feb 2004 14:27:41 +1100
From: Nathan Scott <nathans@sgi.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
Message-ID: <20040226032741.GB1177@frodo>
References: <20040225220051.GA187@schottelius.org> <20040225223428.GD640@frodo> <20040225234944.GD187@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225234944.GD187@schottelius.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

On Thu, Feb 26, 2004 at 12:49:44AM +0100, Nico Schottelius wrote:
> Nathan Scott [Thu, Feb 26, 2004 at 09:34:28AM +1100]:
> > [...] 
> > So, doesn't look like a hard disk error to me, and nor does it
> > look like an XFS problem.  You should be able to run xfs_repair
> > on your loopback file to fix the problem.
> 
> Will reboot in half an hour, but I think as the recovery was done, it
> won't have any problems anymore.

Well, recovery is a garbage-in, garbage-out process - I
think you will need to repair that loopback file.

> There are still some questions open for me:
> 
> 1. why is it an internal xfs error?

Your loopback file seems to have got corrupted, XFS reports
this as an internal error (generic error message).

> 2. why does it print a call trace?

XFS detected corruption, and tried to dump out some state info
at the point where it noticed the problem.

> 3. how can I find out what's wrong / what should I do when seeing call
>    traces? And what should I've done before (adding debugging somewhere?)

xfs_repair will tell you whats wrong, and should fix it.

cheers.

-- 
Nathan
