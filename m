Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268337AbTBSKFO>; Wed, 19 Feb 2003 05:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268339AbTBSKFO>; Wed, 19 Feb 2003 05:05:14 -0500
Received: from ns.suse.de ([213.95.15.193]:35849 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268337AbTBSKFN>;
	Wed, 19 Feb 2003 05:05:13 -0500
Date: Wed, 19 Feb 2003 11:15:15 +0100
From: Dave Jones <davej@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030219111515.B15407@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Chris Wedgwood <cw@f00f.org>, Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>, linux@brodo.de
References: <20030218214220.GA1058@elf.ucw.cz> <20030218214726.GB15007@f00f.org> <20030218215819.GC21974@atrey.karlin.mff.cuni.cz> <20030218220858.GA15273@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030218220858.GA15273@f00f.org>; from cw@f00f.org on Tue, Feb 18, 2003 at 02:08:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 02:08:58PM -0800, Chris Wedgwood wrote:
 > On Tue, Feb 18, 2003 at 10:58:19PM +0100, Pavel Machek wrote:
 > 
 > > Well, and does slow-low-power mean 300MHz, 1.4V as bios said, or
 > > 300MHz, 1.2V which is probably also safe?
 > 
 > I have no idea... that's the point... the user almost never knows what
 > *exact* magic values are required, they just want fast-on-power or
 > slow-on-battery sort of thing.

One possibility is a database of known-safe overrides for specific
models of laptops.  We *could* even do DMI based overrides which make
cpufreq point at an in-module PST instead of BIOS. That in-module PST
would be machine-independant, and would need to be derived by someone
like Pavel using a patch pretty much like the one he proposed to do
trial and error testing. The only thing I'm concerned about with that
approach is the risk of possible damage.

longhaul will allow you to overclock/overpower the cpu. I've never
actually damaged a C3 in this way, just locked it up needing a
power-cycle.  powernow-k7 clips in hardware to the maximum the cpu
is capable of.  Specifying too low a voltage also seems to universally
lock up the box. Those are the implementations I know about, so unless
any of the other implementations allow dangerous operations, we should
be 'mostly harmless' right now.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
