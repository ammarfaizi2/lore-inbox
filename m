Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUFLUxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUFLUxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUFLUxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:53:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:59847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264918AbUFLUxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:53:04 -0400
Date: Sat, 12 Jun 2004 13:53:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040612135302.Y22989@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net> <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Sat, Jun 12, 2004 at 12:48:40AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> On Jun 11, 2004, at 23:15, Chris Wright wrote:
> > Hrm.  Wouldn't it be possible that two processes with same uid have
> > authenticated in different domains, and as such shouldn't be allowed to
> > touch each other's PAGs?  Or is this not allowed?
> 
> Linux doesn't really support the idea that a process should not be able 
> to
> affect another process in the same UID.  There's too many things that

Actually that's not the case.  The UID is currently insufficient to
describe the security domain that a process is running in.  The whole
of the LSM infrastructure is designed with this in mind.  So somehting
like SELinux may enforce a security domain change (w/out a UID change)
across an execve() of pagsh.  I was simply trying to ascertain if you
were storing this within task->user which I think would be wrong.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
