Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTIQCH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTIQCH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:07:29 -0400
Received: from animal.blarg.net ([206.124.128.1]:45518 "EHLO animal.blarg.net")
	by vger.kernel.org with ESMTP id S262590AbTIQCHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:07:24 -0400
Date: Tue, 16 Sep 2003 19:07:23 -0700
From: Ben Johnson <ben@blarg.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030916190723.A26053@blarg.net>
References: <20030916154747.A22526@blarg.net> <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com> <1563260000.1063760286@[10.10.2.4]> <20030916184421.A25733@blarg.net> <20030917015527.GX4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917015527.GX4306@holomorphy.com>; from wli@holomorphy.com on Tue, Sep 16, 2003 at 06:55:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 06:55:27PM -0700, William Lee Irwin III wrote:
> 
> You might want to look at intel's volume 3. They're kept in dedicated
> registers separate from the pointers and used implicitly.

I've been reading that too.  The problem is that there are 6 segment
selector registers and 4 of those are just for data segments.  several
data segments can be in use simultaneously and they can all have
different base addresses and limits.  The only explanation I've found so
far about how a segment is chosen is that logical address are 48-bit
values, yet sizeof(void *) == 4.  there has to be a way to match up
pointer with a segment, but I am unable to find it so far.  (maybe I
need a nap.)

Thanks,

- Ben

