Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbTLHQvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265432AbTLHQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:49:39 -0500
Received: from holomorphy.com ([199.26.172.102]:55259 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265092AbTLHQrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:47:32 -0500
Date: Mon, 8 Dec 2003 08:47:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031208164727.GX19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20031206024251.GG8039@holomorphy.com> <20031206050908.GL8039@holomorphy.com> <1070687655.1166.6.camel@chevrolet.hybel> <20031206054031.GM8039@holomorphy.com> <br2722$f9q$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <br2722$f9q$1@gatekeeper.tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 03:57:54PM +0000, bill davidsen wrote:
>   I don't follow your thinking here, 2.6.0 is certainly frozen, but I
> see no reason this can't be fixed in 2.6 if someone cares to do so. The
> amount of code is small, and as long as the interrupt gets serviced by
> exactly one CPU I doubt the performance could get worse.
>   I don't see ia32 going away, either, unless you see 2.7 in a more
> distant timeframe than I do. Looking at the power issue I predict
> significant ia32 in laptops, and due to cost issues in desktops and
> servers. Also, I suspect that Linux hackers have a much higher
> percentage of SMP ia32 machines than the general public, which
> encourages enhancements in that area.

What I'm on about is that some interfaces internal to arch/i386/ for
APIC management are ad hoc and the configuration boundaries and case
analysis in the code don't match the configuration boundaries or cases
of the hardware. The API has to change to accurately describe machines
in order to accurately drive the machines.

The worst offense for end users is probably the mismeasured physical
APIC ID space on smaller (mach-default) xAPIC systems which should
lose cpus with sufficiently sparse physical APIC ID's. The only current
use of physical broadcast is for clustered hierarchical serial APIC RTE's.

-- wli
