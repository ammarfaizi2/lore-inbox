Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTAYXOC>; Sat, 25 Jan 2003 18:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTAYXOC>; Sat, 25 Jan 2003 18:14:02 -0500
Received: from holomorphy.com ([66.224.33.161]:39839 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264920AbTAYXOB>;
	Sat, 25 Jan 2003 18:14:01 -0500
Date: Sat, 25 Jan 2003 15:23:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, rpjday@mindspring.com,
       linux-kernel@vger.kernel.org
Subject: Re: test suite?
Message-ID: <20030125232306.GZ780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	rpjday@mindspring.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0301241741470.9816-100000@dragon.pdx.osdl.net> <Pine.LNX.4.44.0301252011420.1784-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301252011420.1784-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Randy.Dunlap wrote:
>> Anyone, where is this kernel size limit coming from?
>>   System is 8384 kB
>>   System is too big. Try using modules.

On Sat, Jan 25, 2003 at 08:22:10PM +0000, Hugh Dickins wrote:
> See pg0 and pg1 in arch/i386/kernel/head.S.  There's no technical
> reason (but well-justified resistance to bloat) why pg2... cannot
> be added, but you might find a few little adjustments needed to
> match elsewhere (if you want your testbuild kernel to boot).

It's actually a relatively annoying limit, as various boxen's MP tables
ACPI tables etc. etc. are well above 8MB. At some point one of us should
quash that issue permanently and dynamically map the things. IIRC Linux
needs NUMA-Q boxen to get lynxers reflashed to move MP tables below 8MB
to boot atm. mbligh can more accurate describe the pain involved there.
As for the bzImage, don't bother supporting excess bloat.

All I can say is, "bring me the head of the first moron who shoves some
table needed at boot-time above 4GB".


-- wli
