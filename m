Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTBDKL6>; Tue, 4 Feb 2003 05:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267217AbTBDKL6>; Tue, 4 Feb 2003 05:11:58 -0500
Received: from dux1.tcd.ie ([134.226.1.23]:57310 "HELO dux1.tcd.ie")
	by vger.kernel.org with SMTP id <S267216AbTBDKL5>;
	Tue, 4 Feb 2003 05:11:57 -0500
Subject: RE: CPU throttling??
From: Seamus <assembly@gofree.indigo.ie>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044354123.17354.23.camel@taherias.sre.tcd.ie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 04 Feb 2003 10:22:08 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 21:14, Grover, Andrew wrote:
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
> 
> Valdis, you may want to try compiling in ACPI and ACPI Processor support
> in 2.5.latest and see what happens to your battery life (if you haven't
> tried already). (A caveat - ACPI still doesn't work for everyone, but if
> it does, you should see a power savings.)
> 
> Regards -- Andy

Hmmm, it seems most of these apply to mobile processors.
I'm using AMD 1.4 Athlon Thunderbird on a desktop, as you know my
processor was the one before release low power AMD XP processors.
It uses a savage amount of power, and operates well into 60 and 70
degrees celcius.

I'm not a big linux head, can someone through me an ACPI link, related
to this issue of CPU C state?

One other thing, apart from saving power on CPU and hard-disk (via
hdparm) is there anything else I can look into ? something worthy
though.

Thanks,

Seamus

