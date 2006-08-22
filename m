Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWHVFPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWHVFPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWHVFPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:15:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750737AbWHVFPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:15:03 -0400
Date: Mon, 21 Aug 2006 22:14:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: anton@samba.org, simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060821221433.2bc18198.akpm@osdl.org>
In-Reply-To: <20060821220625.36abd1d9.pj@sgi.com>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060821220625.36abd1d9.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 22:06:25 -0700
Paul Jackson <pj@sgi.com> wrote:

> Andrew wrote:
> > If the kernel provider (ie: distro) has enabled cpusets then it would be
> > appropriate that they also provide a hotplug script which detects whether their
> > user is actually using cpusets and if not, to take some sensible default action
> 
> Interesting point - whether the default action to fix up the
> cpuset configuration when a CPU goes on or offline should be:
>  1) coded in kernel/cpuset.c, or
>  2) coded in a hotplug script.
> 
> I've got 25 cents that says Andrew votes for (2).
> 
> At least so far as the cpuset aware portion of the coding goes,
> it would probably be easier for me to code in a hotplug script.
> 
> I should learn enough about how hotplug scripts work to see if
> this will really work.
> 

Well...  let's suck it and see (please).  If for some reason it proves
inadequate and the default kernel behaviour is significantly wrong (it
seems to be) then there's an argument for modifying (ie: adding complexity
to) the kernel.

But I don't think we yet know that.
