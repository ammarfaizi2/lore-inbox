Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSAOVjK>; Tue, 15 Jan 2002 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290292AbSAOViv>; Tue, 15 Jan 2002 16:38:51 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:18602 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S290289AbSAOVik>;
	Tue, 15 Jan 2002 16:38:40 -0500
Date: Tue, 15 Jan 2002 21:38:35 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Larry McVoy <lm@bitmover.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
Message-ID: <192999434.1011130714@[195.224.237.69]>
In-Reply-To: <20020114105341.E27433@work.bitmover.com>
In-Reply-To: <20020114105341.E27433@work.bitmover.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 14 January, 2002 10:53 AM -0800 Larry McVoy <lm@bitmover.com> 
wrote:

> Eric, your approach is pushing Aunt Tillie towards
> more variations and what the Aunt Tillie needs is less.   Ditto for the
> distro vendors.

Not entirely.

If Aunt Tillie has (say) a laptop, I think she is likely to find that no
distribution kernel actually supports all features (sound, APM, etc.)
if the laptop is even moderately new. This from experience with
Redhat & Debian (perhaps the others are miles better). So she
does indeed have a reasonable need to compile a kernel.

However, Eric's approach (dmesg) is still flawed as normally
the way these distros fail is either (a) hanging on boot, or
(b) failing to detect the relevant hardware. Needless to say,
neither failure mode is going to give much use to a configurator
tool which looks at dmesg.

Eric: I think you'd be far better off trying to identify the
machine (and hence get a working .config) rather than the
hardware.

Example: put in some wget based thingy, which goes to some (fixed) web
site, searches for (some extracted or Tillie composed string) which
describes the hardware (bound to have been bought as-is and never opened),
pulls down a set of config files and heuristics to determine between them
(look at BIOS, or 'that model will always show this or that in the PCI
table') and guesses the correct (initial) config as tested by some other
user. This is the automated equivalent of going to www.google.com/linux,
typing your machine name followed by 'kernel .config'. If the site
it contacted was configurable by the distro, you'd then have
the distros praising you in that once they have solved the problem
for one IBM T23, they've solved it for all of them, without doing
a new release. And Aunt Tillie (apart from the module changes whatever)
can be using the kernel version etc. from their distro (recompiled),
rather than the latest 2.[2468].xx with lots of new bugs^Wunwanted
fixes in.

--
Alex Bligh
