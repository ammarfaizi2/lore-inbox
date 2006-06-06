Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWFFWPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWFFWPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFFWPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:15:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751186AbWFFWPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:15:33 -0400
Date: Tue, 6 Jun 2006 15:15:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Don Zickus <dzickus@redhat.com>
Cc: ak@suse.de, shaohua.li@intel.com, miles.lane@gmail.com, jeremy@goop.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in
 arch/i386/kernel/nmi.c:174
Message-Id: <20060606151507.613edaad.akpm@osdl.org>
In-Reply-To: <20060606214553.GB11696@redhat.com>
References: <4480C102.3060400@goop.org>
	<1149576246.32046.166.camel@sli10-desk.sh.intel.com>
	<20060606141755.GN2839@redhat.com>
	<200606061618.15415.ak@suse.de>
	<20060606214553.GB11696@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 17:45:53 -0400
Don Zickus <dzickus@redhat.com> wrote:

> On Tue, Jun 06, 2006 at 04:18:15PM +0200, Andi Kleen wrote:
> > 
> > > Because he is using a i386 machine, the nmi watchdog is disabled by
> > > default. 
> > 
> > I changed that - it's now on by default on i386 too.
> > 
> > -Andi
> 
> I am trying to create a patch for this problem and it just dawned on me,
> how does one store the previous state in a suspend/resume path if the code
> hotplugs all the cpus first?  CPU0 is easy because an explicit
> suspend/resume path is called, but it seems to be called last after all
> the other cpus have been removed.  How do I save the state?

I'm really struggling to understand this question.  If you're referring to
some per-cpu state then a CPU hotplug handler would be appropriate?
