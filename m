Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUF2CeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUF2CeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUF2CeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:34:14 -0400
Received: from mail1.cluenet.de ([195.20.121.7]:21901 "EHLO mail1.cluenet.de")
	by vger.kernel.org with ESMTP id S265266AbUF2CeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:34:12 -0400
Date: Tue, 29 Jun 2004 04:34:11 +0200
From: Daniel Roesen <dr@cluenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
Message-ID: <20040629043411.A5054@homebase.cluenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com> <cbp62t$a38$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <cbp62t$a38$1@news.cistron.nl>; from miquels@cistron.nl on Mon, Jun 28, 2004 at 01:22:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:22:37PM +0000, Miquel van Smoorenburg wrote:
> MD5 protection on BGP sessions isn't very common yet. MD5 uses CPU,
> and routers don't usually have much of that. Which means that now an
> MD5 CPU attack is possible instead of a TCP RST attack.

Not if the MD5 option is properly implemented - i.e. MD5 hash checking
is done AFTER the packet is considered valid in terms of "fitting"
sequence number.

> The "TTL hack" solution is safer. Make sure sender uses a TTL
> of 255, on the receiver discard all packets with a TTL < 255.

It's a hack, not a solution. A solution works always, not just in
some special cases (and given Cisco's implementation, even there
is a window which is "too wide open").

As this thread is fairly off-topic on lkml, I suggest moving it to
somewhere else... But then again, in the appropriate places, these
discussions have already taken place. :-)


Regards,
Daniel
