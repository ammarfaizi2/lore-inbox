Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289877AbSAKFCr>; Fri, 11 Jan 2002 00:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289878AbSAKFC2>; Fri, 11 Jan 2002 00:02:28 -0500
Received: from holomorphy.com ([216.36.33.161]:5771 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289877AbSAKFCW>;
	Fri, 11 Jan 2002 00:02:22 -0500
Date: Thu, 10 Jan 2002 21:01:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dan Chen <crimsun@email.unc.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Memory management problems in 2.4.16
Message-ID: <20020110210154.A934@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dan Chen <crimsun@email.unc.edu>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020110224036.GA32522@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33L.0201110141090.2985-100000@imladris.surriel.com> <20020111044608.GA26644@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020111044608.GA26644@opeth.ath.cx>; from crimsun@email.unc.edu on Thu, Jan 10, 2002 at 11:46:08PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 11:46:08PM -0500, Dan Chen wrote:
> And on a PII/400 limited to "mem=64M", a `dbench 60` running with XMMS
> 1.2.6 did not cause any noticeable audio breakup. This is on 2.4.17 +
> rmap10c + ide.2.4.16.12102001 + Bill's original hashed waitqueues patch.
> (I should also add that XMMS was not running with realtime priority.)
> I'll see if I can produce some numbers in a bit.

On Fri, Jan 11, 2002 at 01:42:03AM -0200, Rik van Riel wrote:
>> I've been running a few hours of low memory testing with
>> my rmap VM and it's holding up fine. The system is still
>> responsive when the amount of pageable RAM is down to
>> about 400 kB ;))

Any chance you could include the results of the following:

/usr/sbin/readprofile -m /boot/System.map-`uname -r` | sort -rn -k1,1 | head
cat /proc/interrupts
cat /proc/slabinfo
cat /proc/meminfo

and a few lines of vmstat 10 ?


Thanks,
Bill
