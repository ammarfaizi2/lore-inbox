Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTDOPDS (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTDOPDS 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:03:18 -0400
Received: from holomorphy.com ([66.224.33.161]:48518 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261623AbTDOPDR 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:03:17 -0400
Date: Tue, 15 Apr 2003 08:14:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nagy Tibor <nagyt@otpbank.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
Message-ID: <20030415151439.GC12487@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nagy Tibor <nagyt@otpbank.hu>, linux-kernel@vger.kernel.org
References: <3E9C19A2.1040206@dell633.otpefo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9C19A2.1040206@dell633.otpefo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 04:39:30PM +0200, Nagy Tibor wrote:
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> <4> BIOS-e820: 0000000000100000 - 00000000fbffe000 (usable)
> <4> BIOS-e820: 00000000fbffe000 - 00000000fc000000 (reserved)
> <4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> <4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
> <4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> <5>3135MB HIGHMEM available.
> <5>896MB LOWMEM available.
[...]
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> <4> BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
> <4> BIOS-e820: 00000000dfff0000 - 00000000dfffec00 (ACPI data)
> <4> BIOS-e820: 00000000dfffec00 - 00000000dffff000 (reserved)
> <4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> <4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
> <4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> <5>2687MB HIGHMEM available.
> <5>896MB LOWMEM available.
> There is a big hole between 00000000dffff000 and 00000000fec00000, which
> is not used on the new machine. What can I do?

Presumably that was lost to ACPI. The hole between 0xdffff000 and
0xfec00000 appears to not be covered by the e820.

Try turning ACPI off in your .config since there's something that
looks relevant to it different between 2.4 and 2.5. You also might
want to follow up with .config's just in case. I'll look at 2.5's e820
stuff, but no promises.


-- wli
