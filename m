Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTIQCcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTIQCcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:32:06 -0400
Received: from blarg.net ([206.124.128.1]:7631 "EHLO animal.blarg.net")
	by vger.kernel.org with ESMTP id S262656AbTIQCcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:32:04 -0400
Date: Tue, 16 Sep 2003 19:32:03 -0700
From: Ben Johnson <ben@blarg.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030916193203.B26053@blarg.net>
References: <20030916154747.A22526@blarg.net> <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com> <1563260000.1063760286@[10.10.2.4]> <20030916184421.A25733@blarg.net> <20030917015527.GX4306@holomorphy.com> <20030916190723.A26053@blarg.net> <20030917021045.GY4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917021045.GY4306@holomorphy.com>; from wli@holomorphy.com on Tue, Sep 16, 2003 at 07:10:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 07:10:45PM -0700, William Lee Irwin III wrote:
> 
> The way the extra data segment registers are used is by explicitly
> qualifying operands with segments.

ah!  now that makes sense.

So, I'm guessing the DS register is used by default to select the base
address for all non-stack oriented operations.  And I bet the SS
register is used by default for stack oriented operations, and all ops
that act on %esp (and %ebp?).  I think that make my life easier.

Thanks a lot!

- Ben

