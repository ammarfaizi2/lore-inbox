Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTAFOkI>; Mon, 6 Jan 2003 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTAFOkI>; Mon, 6 Jan 2003 09:40:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16147 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265608AbTAFOkI>; Mon, 6 Jan 2003 09:40:08 -0500
Date: Mon, 6 Jan 2003 15:48:43 +0100
From: Jan Kara <jack@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030106144842.GD24714@atrey.karlin.mff.cuni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030106103656.GA508@mail.muni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Sun, Jan 05, 2003 at 05:59:12PM -0800, Andrew Morton wrote:
> > grab-n-build quota-3.08 from http://sourceforge.net/projects/linuxquota
> 
> $ dpkg -l quota
> ii  quota          3.08-1
> 
> > # quotacheck -F vfsv0 /dev/sde5
> 
> this one works ok. quotacheck -m -F vfsv0 / seems to be working
> 
> > # quotaon /dev/sde5
> 
> quotaon / freezes process if system is up in normal mode. More over any process
> cannot read nor write to disk after that. sysrq-p shows cpu in idle only.
  I seems like quotaon (or better quotactl()) waits on some lock
forever... I'll try to reproduce it but in the mean time can you print
list of processes, write down a few addresses from the top of the stack
of quotaon and try to match it in the system.map to function in which
is process stuck?

> when init=/bin/sh then it reports no such device.
  Hmm.. This might be helpful. Thanks.


> under 2.5.53 and 2.4.20 quotaon works ok. Under 2.5.53 quotaoff / reports some
> error - no such device or bad ioctl I cannot remember exactly but process does
> not freeze.


						Thanks for report
								Honza
