Return-Path: <linux-kernel-owner+w=401wt.eu-S1762299AbWLJSHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762299AbWLJSHb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 13:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762298AbWLJSHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 13:07:31 -0500
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:43963 "EHLO
	hoboe1bl1.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762299AbWLJSHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 13:07:30 -0500
Date: Sun, 10 Dec 2006 19:07:25 +0100
From: Wouter Verhelst <wouter@grep.be>
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Clements <paul.clements@steeleye.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: show nbd client pid in sysfs
Message-ID: <20061210180725.GA29943@country.grep.be>
References: <45762745.7010202@steeleye.com> <20061208211723.GC4924@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208211723.GC4924@ucw.cz>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 09:17:23PM +0000, Pavel Machek wrote:
> Hi!
> 
> > This simple patch allows nbd to expose the nbd-client 
> > daemon's PID in /sys/block/nbd<x>/pid. This is helpful 
> > for tracking connection status of a device and for 
> > determining which nbd devices are currently in use.
> 
> Actually is it needed at all? Perhaps nbd clients should be modified
> to put nbdX in their process nam?

I don't think that's the right approach; only the kernel can guarantee
that a given process is actually managing a given nbd device (I could
have some rogue process running around announcing that it's managing
nbd2, and then what?)

-- 
<Lo-lan-do> Home is where you have to wash the dishes.
  -- #debian-devel, Freenode, 2004-09-22
