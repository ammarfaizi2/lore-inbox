Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTLVVND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTLVVNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:13:02 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:51371 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264490AbTLVVNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:13:00 -0500
Date: Mon, 22 Dec 2003 23:12:47 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031222211247.GL1455@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net> <Pine.LNX.4.58L.0312211832320.6632@logos.cnet> <20031221210917.GB4897@ovh.net> <20031221222338.GC1323@alpha.home.local> <20031222070344.GL1524@niksula.cs.hut.fi> <20031222183554.GN6438@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222183554.GN6438@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 10:35:54AM -0800, you [Mike Fedyk] wrote:
> > 
> > I don't know if there is a kernel memory leak, since all user level
> > processes should be killed at that point, right? Unfortunately I didn't have
> > time to dig deeper, as the box is in (sort of) production.
> 
> Maybe, it depends on your init scripts.  Does your distribution do a kill -9
> of all processes before turning off swap?

(It's a 7.0 Red Hat).

It does 
   runcmd "Sending all processes the KILL signal..."  /sbin/killall5 -9
before
   [ -n "$SWAPS" ] && runcmd "Turning off swap: " swapoff $SWAPS
in /etc/rc6.d/S01reboot and I've seen the "Sending all processes the KILL
signal..." message appear before the memory freeing loop starts rolling.

 
-- v --

v@iki.fi
