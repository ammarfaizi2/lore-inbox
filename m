Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTIQCJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTIQCJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:09:40 -0400
Received: from holomorphy.com ([66.224.33.161]:36817 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262591AbTIQCJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:09:37 -0400
Date: Tue, 16 Sep 2003 19:10:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ben Johnson <ben@blarg.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030917021045.GY4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ben Johnson <ben@blarg.net>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030916154747.A22526@blarg.net> <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com> <1563260000.1063760286@[10.10.2.4]> <20030916184421.A25733@blarg.net> <20030917015527.GX4306@holomorphy.com> <20030916190723.A26053@blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916190723.A26053@blarg.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 06:55:27PM -0700, William Lee Irwin III wrote:
>> You might want to look at intel's volume 3. They're kept in dedicated
>> registers separate from the pointers and used implicitly.

On Tue, Sep 16, 2003 at 07:07:23PM -0700, Ben Johnson wrote:
> I've been reading that too.  The problem is that there are 6 segment
> selector registers and 4 of those are just for data segments.  several
> data segments can be in use simultaneously and they can all have
> different base addresses and limits.  The only explanation I've found so
> far about how a segment is chosen is that logical address are 48-bit
> values, yet sizeof(void *) == 4.  there has to be a way to match up
> pointer with a segment, but I am unable to find it so far.  (maybe I
> need a nap.)

Logical addresses aren't 48-bit; they're just offset from linear (and
vice-versa).

The way the extra data segment registers are used is by explicitly
qualifying operands with segments.


-- wli
