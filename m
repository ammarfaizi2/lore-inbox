Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTBCWVv>; Mon, 3 Feb 2003 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTBCWVv>; Mon, 3 Feb 2003 17:21:51 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:25323 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267032AbTBCWVr>; Mon, 3 Feb 2003 17:21:47 -0500
Date: Tue, 4 Feb 2003 00:31:05 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-ID: <20030203223104.GA1258@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 01:14:18PM -0800, you [Grover, Andrew] wrote:
> > From: Dave Jones [mailto:davej@codemonkey.org.uk] 
> > Valdis.Kletnieks@vt.edu wrote:
> > 
> >  > It's conceivable that a CPU halted at 1.2Gz takes less 
> > power than one
> >  > at 1.6Gz - anybody have any actual data on this?  
> > Alternately phrased,
> >  > does CPU throttling save power over and above what the halt does?
> > 
> > Given that most decent implementations scale voltage as well as
> > frequency, yes, a lower speed will save more power.
> 
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

Interesting.

So, what sw does one need for this CPU C state? Which kernels support it /
which patches are needed? 2.5 only?

Also, which CPUs support it? Am I out of luck with my measly 1.4 Celeron
Tualatin?

So far I've only been doing "Make CPU Idle calls when idle", which I gather
is far from optimal?


-- v --

v@iki.fi
