Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTESR3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTESR3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:29:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34741 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262578AbTESR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:29:14 -0400
Date: Mon, 19 May 2003 17:42:03 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: time interpolation hooks
Message-ID: <20030519174203.A7061@devserv.devel.redhat.com>
References: <20030516142311.3844ee97.akpm@digeo.com> <16069.24454.349874.198470@napali.hpl.hp.com> <1053139080.7308.6.camel@rth.ninka.net> <16073.5555.158600.61609@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16073.5555.158600.61609@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, May 19, 2003 at 10:34:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:34:43AM -0700, David Mosberger wrote:
> 
> struct time_interpolator {
> 	void (*update_wall_time) (long delta_nsec);
> 	void (*reset_wall_time) (long delta_nsec);
> 	unsigned long frequency;	/* frequency in counts/second */
> 	unsigned long drift;		/* drift in parts-per-million (?) */
> };

probably also a "get interpolated value" kind of thing ?
other than that it seems to match what I had in mind.
For the score we may need something creative; I'm not sure all timers
have a defined drift, otoh parts-per-million seems to be the
standard mechanism of reporting this.

Greetings,
   Arjan van de Ven
