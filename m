Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSKNEYE>; Wed, 13 Nov 2002 23:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSKNEYE>; Wed, 13 Nov 2002 23:24:04 -0500
Received: from mail.michigannet.com ([208.49.116.30]:41230 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S264628AbSKNEYD>; Wed, 13 Nov 2002 23:24:03 -0500
Date: Wed, 13 Nov 2002 23:30:48 -0500
From: Paul <set@pobox.com>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving from Linux 2.4.19 LVM to LVM2
Message-ID: <20021114043047.GU9928@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Patrick Finnegan <pat@purdueriots.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211132253340.11522-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211132253340.11522-100000@ibm-ps850.purdueriots.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Finnegan <pat@purdueriots.com>, on Wed Nov 13, 2002 [11:05:37 PM] said:
> Is there an easy and plainless way to do this?  Are the LVM2 tools
> backwards-compatible with the old LVM?  I've got important partitions on
> LVM (/usr, /tmp, /var, /home) and I'd like to be able to switch back and
> forth between 2.4 and 2.5 kernels without needing to keep around separate
> copies of bootscripts and userland tools if possible.
> 
> Thanks!
> 
> Pat

	Hi;

	I have been playing with this. The userspace tools are
not backwards compatible. (2.4 tools didnt seem compatible
with 2.2 tools either-- Ive got 3 sets of them laying around)
	Currently, LVM2 under 2.5 repeatedly will hit a BUG() and
oops for me. I also managed to destroy a test striped lv.
I wouldnt trust any important data to it yet.
	(Jens Axboe has expressed a willingness to help with
the problem. Just a matter of time...)
	You need a > 2.5.47 kernel (eg. a recent bk snapshot,
or eg. 2.5.47-ac2 or 2.5.45-mcp2) to even compile with
DM support if you want to play with this.

Paul
set@pobox.com
