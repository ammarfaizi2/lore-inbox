Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRDFLkZ>; Fri, 6 Apr 2001 07:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131486AbRDFLkR>; Fri, 6 Apr 2001 07:40:17 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:30221 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131484AbRDFLju>;
	Fri, 6 Apr 2001 07:39:50 -0400
Date: Fri, 6 Apr 2001 13:39:02 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: alad@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: __switch_to macro
Message-ID: <20010406133902.A5783@pcep-jamie.cern.ch>
In-Reply-To: <65256A26.0031F455.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <65256A26.0031F455.00@sandesh.hss.hns.com>; from alad@hss.hns.com on Fri, Apr 06, 2001 at 02:42:48PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alad@hss.hns.com wrote:
> There's one thing that confuses me: don't you get a segment_not_present
> fault?  If so, traps.c's do_segment_not_present doesn't appear to search
> the exception table, and the code in loadsegment would not work.
> 
> >>> well.. I peeked into traps.c.. I do seem a call to die_if_no_fixup
> in this function. And I think loadsegment is already making an entry in
> exception table.

Ah, you're right.  I didn't follow DO_ERROR all the way to do_trap and
hency search_exception_table.

-- Jamie
