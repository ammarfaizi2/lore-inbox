Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281915AbRLLFPn>; Wed, 12 Dec 2001 00:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282784AbRLLFPd>; Wed, 12 Dec 2001 00:15:33 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:3515
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S282781AbRLLFPX>; Wed, 12 Dec 2001 00:15:23 -0500
Date: Wed, 12 Dec 2001 00:05:06 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.9.6 is available
Message-ID: <20011212000506.A5099@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011209033249.A28867@thyrsus.com> <19176.1007888660@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19176.1007888660@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Dec 09, 2001 at 08:04:20PM +1100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> One niggle, some strings for kuild 2.5 are longer than 30 characters,
> cml2 restricts the string length in make menuconfig.  Only menuconfig
> has this restriction, not oldconfig nor xconfig.  Can the limit be
> removed, or at least changed to $ROWS-n which would adjust to screen
> size?

The only place I see a limit of 30 is in the query_popup function used
for querying for things like search strings, symbol names in the go-to
command, etc. in menuconfig.

The answer is: maybe.  The underlying problem here is that the prompt
string and the string editing area both eat screen width.  30 is about
the largest limit that doesn't blow up the configurator when combined
with the longest prompt strings.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Everything you know is wrong.  But some of it is a useful first approximation.
