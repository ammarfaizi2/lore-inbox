Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290278AbSAOUlW>; Tue, 15 Jan 2002 15:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSAOUlK>; Tue, 15 Jan 2002 15:41:10 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:31105
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290270AbSAOUkz>; Tue, 15 Jan 2002 15:40:55 -0500
Date: Tue, 15 Jan 2002 15:24:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020115152445.B6308@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020115145324.A5772@thyrsus.com> <Pine.SOL.3.96.1020115201156.26402C-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1020115201156.26402C-100000@libra.cus.cam.ac.uk>; from aia21@cus.cam.ac.uk on Tue, Jan 15, 2002 at 08:16:13PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cus.cam.ac.uk>:
> </me ignorant of current state of cml2>I sometimes configure and compile
> kernels for different computers on my athlon due to the extremely fast
> compile time on the athlon. The autoprober would interfere here extremely
> badly. Is it disabled by default? I.e. if I do make menuconfig or make
> oldconfig will the autoprober temper with my choices?

Absolutely not.

To invoke the autoconfigurator, you do one of two things:

`make autoconfigure' 
    This runs the autoconfigurator in standalone mode.  This gives you
an entire configuration, ready to build with.

`make autoprobe {config,menuconfig,xconfig}' 
    This runs the autoconfigurator in probe mode, which gives you
a report on facilities found (without making assumptions about facilities
not found).  This report gets fed to your interactive configurator, which
then proceeds not to bother you with questions for which the autoprobe 
report already gave it answers.

The ordinary make {config,menuconfig,xconfig} behaves as it always did.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

If we believe absurdities, we shall commit atrocities.
		-- Voltaire
