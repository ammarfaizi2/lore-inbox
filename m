Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264592AbSIWFhE>; Mon, 23 Sep 2002 01:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSIWFhE>; Mon, 23 Sep 2002 01:37:04 -0400
Received: from holomorphy.com ([66.224.33.161]:17300 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264592AbSIWFhE>;
	Mon, 23 Sep 2002 01:37:04 -0400
Date: Sun, 22 Sep 2002 22:33:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm1 dbench 512 might sleep backtrace emitted
Message-ID: <20020923053354.GX3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20020923045914.GI25605@holomorphy.com> <3D8EA718.2FC057E5@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8EA718.2FC057E5@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Trace; c01175f7 <__might_sleep+27/2b>

On Sun, Sep 22, 2002 at 10:31:04PM -0700, Andrew Morton wrote:
> Well I can't immediately see any held locks on that path, can
> you?  Odd.
> Might be best to put a breakpoint on the printk in __might_sleep(),
> get some more info if it bites again.
> If there _are_ no locks held in that chain then there is
> something wrong with in_atomic().  So check the current
> task state with `task25' and `thread25' from my .gdbinit.

I squirted it out just in case someone (i.e. you) recognized it off the
bat. I'm looking into it myself also with methods similar to what's
suggested.


Cheers,
Bill
