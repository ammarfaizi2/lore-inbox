Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTICVu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbTICVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:50:58 -0400
Received: from holomorphy.com ([66.224.33.161]:2443 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261427AbTICVu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:50:57 -0400
Date: Wed, 3 Sep 2003 14:51:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030903215135.GY4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115070000.1062624541@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>  SSI clusters have most of the same problems,
>>  really. Managing the systems just becomes "managing the nodes" because
>>  they're not called systems, and you have to go through some (possibly
>>  automated, though not likely) hassle to figure out the right way to
>>  spread things across nodes, which virtualizes pieces to hand to which
>>  nodes running which loads, etc.

On Wed, Sep 03, 2003 at 02:29:01PM -0700, Martin J. Bligh wrote:
> That's where I disagree - it's much easier for the USER because an SSI
> cluster works out all the load balancing shit for itself, instead of
> pushing the problem out to userspace. It's much harder for the KERNEL
> programmer, sure ... but we're smart ;-) And I'd rather solve it once,
> properly, in the right place where all the right data is about all
> the apps running on the system, and the data about the machine hardware.

This is only truly feasible when the nodes are homogeneous. They will
not be as there will be physical locality (esp. bits like device
proximity) concerns. It's vaguely possible some kind of punting out
of the kernel of the solutions to these concerns is possible, but upon
the assumption it will appear, we descend further toward science fiction.

Some of these proposals also beg the question of "who's going to write
the rest of the hypervisor supporting this stuff?", which is ominous.


-- wli
