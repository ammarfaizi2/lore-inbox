Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbTGZRll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270470AbTGZRll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:41:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:52392 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S269334AbTGZRlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:41:40 -0400
Date: Sat, 26 Jul 2003 13:45:08 -0400
From: Ben Collins <bcollins@debian.org>
To: Sam Bromley <sbromley@cogeco.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire (One fix worked, now getting oops)
Message-ID: <20030726174508.GE490@phunnypharm.org>
References: <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net> <20030725201128.GA535@phunnypharm.org> <1059194478.655.49.camel@daedalus.samhome.net> <20030726151247.GC490@phunnypharm.org> <1059241272.757.7.camel@daedalus.samhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059241272.757.7.camel@daedalus.samhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 01:41:12PM -0400, Sam Bromley wrote:
> On Sat, 2003-07-26 at 11:12, Ben Collins wrote:
> > > >>EIP; 402fd1de <__crc_param_set_short+2b6895/75bf8f>   <=====
> > > 
> > > >>ebx; 4039ff60 <__crc_param_set_short+359617/75bf8f>
> > > >>edx; 08103a88 <__crc_ip_finish_output+23c39/133bb1>
> > > >>ebp; bfffc788 <__crc_class_device_add+4dfb67/51fa16>
> > > >>esp; bfffc760 <__crc_class_device_add+4dfb3f/51fa16>
> > 
> > This doesn't make much sense. I'm not sure what to make of it.
> 
> 
> Well, I compiled without preempt and the problem went away.
> Everything now seems to work (using Rev 1016). The oops
> upon unloading ohci1394 is gone as well. Are others
> having success *with* a preemptibe kernel?

I'm not sure how to get around the problem with unload. I call
wait_for_completion() to make sure the kernel thread in nodemgr is dead,
but it ends up sleeping and that causes the problem. I am under a
read_lock when this occurs, and I'm not sure I can get around that fact.



-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
