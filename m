Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbTF1BeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbTF1BeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:34:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58575
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265012AbTF1BdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:33:25 -0400
Date: Sat, 28 Jun 2003 03:47:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21rc8aa1
Message-ID: <20030628014722.GE3040@dualathlon.random>
References: <20030612032021.GB1571@dualathlon.random> <20030628013435.GG9706@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628013435.GG9706@werewolf.able.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 03:34:35AM +0200, J.A. Magallon wrote:
> 
> Hi,
> 
> On 06.12, Andrea Arcangeli wrote:
> > This version has some experimental change to the blkdev layer (latency
> > fixes from Chris and Nick too plus the backout of the rc6 latency change
> > to see if we can fix it w/o generating overscheduling, especially
> > because it doesn't sound the right fix), so I would recommend some
> > beating before doing anything critical with it. I would expect it as
> > worse to deadlock with some task in D state. It worked fine for me so
> > far but I didn't run big stress yet. In theory it should be better, but
> > I just wanted to give a warning until it is better tested ;).
> > 
> > URL:
> > 
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1.gz
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/
> > 
> 
> In sg.c, gcc shouts on:
> 
>     PRINT_PROC("%u\t%hu\t%hd\t%hu\t%d\t%d\n",
>            shp->unique_id, shp->host_busy, shp->cmd_per_lun,
>            shp->sg_tablesize, (int)shp->unchecked_isa_dma,
>            (int)shp->hostt->emulated);
> 
> shp->host_busy should be accessed through atomic_read(), I think.

correct ;), thanks

Andrea
