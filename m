Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbTBCVNt>; Mon, 3 Feb 2003 16:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCVNt>; Mon, 3 Feb 2003 16:13:49 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18578 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266728AbTBCVNr>;
	Mon, 3 Feb 2003 16:13:47 -0500
Date: Mon, 3 Feb 2003 21:18:06 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Valdis.Kletnieks@vt.edu, John Bradford <john@grabjohn.com>,
       Seamus <assembly@gofree.indigo.ie>, linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-ID: <20030203211806.GA21312@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Grover, Andrew" <andrew.grover@intel.com>, Valdis.Kletnieks@vt.edu,
	John Bradford <john@grabjohn.com>,
	Seamus <assembly@gofree.indigo.ie>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 01:14:18PM -0800, Grover, Andrew wrote:

 > You save the most power when the CPU is at the lowest voltage level, and
 > in the deepest CPU sleep state (aka CPU C state).
 > 
 > Throttling offers a linear power/perf tradeoff if your system doesn't
 > have C state support (or if you aren't using it) but really it is
 > preferable to keep the CPU at its nominal speed, get the work done
 > sooner, and start sleeping right away. The quote above makes it sound
 > like the voltage is scaled when throttling, and that isn't accurate -
 > voltage is scaled when sleeping (to counteract leakage current), at
 > least on modern Intel mobile processors.

Most (all?[1]) other modern x86 mobile processors behave the way I mentioned.
AMD Powernow (K6 and K7), VIA longhaul/powersaver all have optimal voltages
they can be run at when clocked to different speeds. By way of example, a table from
my mobile athlon..

    FID: 0x12 (4.0x [532MHz])   VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])    VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])    VID: 0x13 (1.200V)
    FID: 0xa (8.0x [1064MHz])   VID: 0xd (1.350V)
    FID: 0xf (10.5x [1396MHz])  VID: 0x9 (1.550V)

Sure I *could* run that at 523MHz and still pump 1.550V into it,
but why would I want to do that ?

		Dave

[1] Unsure about the crusoe.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
