Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283717AbRLMIw3>; Thu, 13 Dec 2001 03:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283733AbRLMIwT>; Thu, 13 Dec 2001 03:52:19 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:16836
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283723AbRLMIwM>; Thu, 13 Dec 2001 03:52:12 -0500
Date: Thu, 13 Dec 2001 03:41:35 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.9.7 is available
Message-ID: <20011213034135.A8267@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011212023556.A8819@thyrsus.com> <16992.1008153373@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16992.1008153373@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Wed, Dec 12, 2001 at 09:36:13PM +1100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> Dangling symlink kernel-tree/scripts/tree.py breaks the CML2 install,
> rm kernel-tree/scripts/tree.py first.

Fixed.
 
> There are still discrepancies between the output produced by different
> forms of make *config.  I am also seeing spurious deduction messages
> which may be related or may be a separate problem.

Separate problem. 

> Why are those deduction messages appearing in menuconfig?  I just did
> make oldconfig, the config should be stable.  I did not change anything
> in menuconfig, just saved it.

The deduction messages are happening because the side-effect forcing
logic fires whenever a symbol is set.  It has no way of knowing
whether or not the forced symbol will occur later in the config being read.
This 

> Why is the output after menuconfig WITH NO CHANGES different from
> the oldconfig that went into menuconfig?

I think it's because of the different timing of menu visits (forcing computation
of choice-menu defaults at different times).  I'm going to run some experiments
to see if I can pin this down.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The state calls its own violence `law', but that of the individual `crime'"
	-- Max Stirner
