Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUIKW2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUIKW2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 18:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUIKW2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 18:28:41 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11201 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268342AbUIKW2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 18:28:37 -0400
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20040909191142.GA30151@k3.hellgate.ch>
References: <20040908184028.GA10840@k3.hellgate.ch>
	 <20040908184130.GA12691@k3.hellgate.ch>
	 <20040909003529.GI3106@holomorphy.com>
	 <20040909184300.GA28278@k3.hellgate.ch>
	 <20040909184933.GG3106@holomorphy.com>
	 <20040909191142.GA30151@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1094941556.1173.12.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Sep 2004 18:25:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 15:11, Roger Luethi wrote:
> On Thu, 09 Sep 2004 11:49:33 -0700, William Lee Irwin III wrote:
> > I'll follow up shortly with a task_mem()/task_mem_cheap() consolidation
> > patch atop the others I sent.
> 
> I have a few minor changes coming up as well.
> 
> One nitpick: As vmexe and vmlib are always 0 for !CONFIG_MMU, we should
> ifdef them out of the list of offered fields for that configuration (and
> maybe in nproc_ps_field as well).

No. First of all, I think they can be offered. Until proven
otherwise, I'll assume that the !CONFIG_MMU case is buggy.

Second of all, removal will make the !CONFIG_MMU systems
less compatible with the rest of the world. This will
mean that fewer apps can run on !CONFIG_MMU boxes. It's
same problem as "All the world's a VAX". It's better that
the apps work; an author working on a Pentium 4 Xeon is
likely to write code that relies on the fields and might
not really understand what "no MMU" is all about.



