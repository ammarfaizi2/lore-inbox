Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270404AbTGRXt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270418AbTGRXt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:49:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58563
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270404AbTGRXt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:49:58 -0400
Date: Sat, 19 Jul 2003 02:04:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030719000453.GD19045@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org> <20030718222750.GL3928@dualathlon.random> <20030718224824.GP15452@holomorphy.com> <20030718225328.GQ3928@dualathlon.random> <20030718230431.GQ15452@holomorphy.com> <20030718231230.GA19045@dualathlon.random> <20030718235309.GR15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718235309.GR15452@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 04:53:09PM -0700, William Lee Irwin III wrote:
> On Sat, Jul 19, 2003 at 01:12:30AM +0200, Andrea Arcangeli wrote:
> > so the apps will need changes and a kernel API way to know the hardware
> > page size provided by hugetlbfs (though they could probe for it with
> > many tries).
> 
> The hugepage size is exported in /proc/meminfo for the time being.

ok.

> I think 2.7 will see something we both like better.

the transparency feature in the shm-largepage patch is quite nice since
you could trivially put an app on the fs w/o any breakage that way (not
everything has to be strictly mapped with bigpages, so it would make the
code more relaxed by just changing the mountpoint). Of course a way
to know for sure if a mapping is marked VM_LARGEPAGE would be needed
then to be sure the app has the right pieces of vm backed with the right
page size.

Andrea
