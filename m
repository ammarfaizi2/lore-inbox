Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290238AbSAOStH>; Tue, 15 Jan 2002 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290246AbSAOSs5>; Tue, 15 Jan 2002 13:48:57 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:64128
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290238AbSAOSsj>; Tue, 15 Jan 2002 13:48:39 -0500
Date: Tue, 15 Jan 2002 13:31:30 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: Giacomo Catenazzi <cate@debian.org>, Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Autoconfiguration: Original design scenario
Message-ID: <20020115133130.A3197@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>, Giacomo Catenazzi <cate@debian.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk> <3C442395.8010500@debian.org> <20020115183432.GC27059@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115183432.GC27059@kroah.com>; from greg@kroah.com on Tue, Jan 15, 2002 at 10:34:32AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
> Giacomo, please, please, please, just use the info in the
> MODULE_DEVICE_TABLE entries for your autoconfigure program.

Giacomo will probably answer definitively, but I believe he is already
generating all of the PCI, PNP, and module probes by script.  We're planning
to ship the probe table generator with a future CML2 version.

> One other autoconfigure problem that I don't think anyone has mentioned,
> USB devices that only show up when they want to transfer data to/from
> the host.  Like all of the Palm based devices.  They don't stay
> connected long enough for a "probe all the busses" tool like
> you are currently developing to detect.

Which is why the "standalone" mode of the autoconfigurator turns all that
stuff modular.  The autoprobe doesn't, it's intended to generate a facilities
report that can be used to tune by hand.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never trust a man who praises compassion while pointing a gun at you.
