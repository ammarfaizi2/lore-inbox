Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWHUBbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWHUBbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 21:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWHUBbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 21:31:44 -0400
Received: from mx1.suse.de ([195.135.220.2]:18598 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751798AbWHUBbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 21:31:43 -0400
From: Neil Brown <neilb@suse.de>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Date: Mon, 21 Aug 2006 11:31:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17641.3304.948174.971955@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrzej Szymanski <szymans@agh.edu.pl>
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
In-Reply-To: message from Miquel van Smoorenburg on Thursday August 17
References: <44E0A69C.5030103@agh.edu.pl>
	<ec19r7$uba$1@news.cistron.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 17, miquels@cistron.nl wrote:
> In article <44E0A69C.5030103@agh.edu.pl>,
> Andrzej Szymanski  <szymans@agh.edu.pl> wrote:
> >I've encountered a strange problem - if an application is sequentially 
> >writing a large file on a busy machine, a single write() of 64KB may 
> >take even 30 seconds. But if I do fsync() after each write() the maximum 
> >time of write()+fsync() is about 0.5 second (the overall performance is, 
> >of course, degraded).
> 
> I'm seeing something similar.

Can you report the contents of /proc/meminfo before, during, and after
the long pause?
I'm particularly interested in MemTotal, Dirty, and Writeback, but the
others are of interest too.

Thanks,
NeilBrown
