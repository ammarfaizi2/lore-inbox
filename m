Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264453AbUEXWeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUEXWeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEXWeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:34:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:27580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264453AbUEXWeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:34:00 -0400
Date: Mon, 24 May 2004 15:33:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040524153359.N22989@build.pdx.osdl.net>
References: <67B3A7DA6591BE439001F2736233351202B47E6E@xch-nw-28.nw.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E6E@xch-nw-28.nw.nos.boeing.com>; from Joseph.V.Laughlin@boeing.com on Mon, May 24, 2004 at 03:20:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Laughlin, Joseph V (Joseph.V.Laughlin@boeing.com) wrote:
> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
> 
> Dynamically change the priorities of processes (up and down)

Requires CAP_SYS_NICE.

> Lock processes in memory

Currently requires CAP_IPC_LOCK.  However, this one is already been
done using rlimits (at least via mlock() and friends, SHM_LOCK has
different issue).

> Can change process cpu affinity

Requires CAP_SYS_NICE (but I believe this was a 2.6 feature).

> Anyone got any ideas about how I could start doing this?  (I'm new to
> kernel development, btw.)

There's a few approaches floating about.  Probably the simplest is to
disable the checks globally, but this will also be less secure.  I have
an example of this in 2.6 if you'd like.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
