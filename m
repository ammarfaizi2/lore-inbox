Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285074AbRL0AZF>; Wed, 26 Dec 2001 19:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285077AbRL0AYz>; Wed, 26 Dec 2001 19:24:55 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:13768
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285074AbRL0AYw>; Wed, 26 Dec 2001 19:24:52 -0500
Date: Wed, 26 Dec 2001 19:09:18 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Riley Williams <rhw@memalpha.cx>
Cc: Rik van Riel <riel@conectiva.com.br>, Cameron Simpson <cs@zip.com.au>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011226190918.B6167@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Riley Williams <rhw@memalpha.cx>,
	Rik van Riel <riel@conectiva.com.br>,
	Cameron Simpson <cs@zip.com.au>,
	David Garfield <garfield@irving.iisd.sra.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011223174608.A25335@thyrsus.com> <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX>; from rhw@memalpha.cx on Wed, Dec 26, 2001 at 05:44:36PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@memalpha.cx>:
> Alternatively, deal with this problem the same way the "This may also be
> built as a module..." comment is - either include it several thousand
> times in Configure.help or (better still) have the configuration tools
> spit it out automatically every time the need for it crops up. The
> following ruleset could easily be implemented even in the `make config`
> and `make menuconfig` parsers, and should be just as easy in CML2.
> Applying rule (1) will result in a considerable reduction in the size of
> the file Documentation/Configure.help as it currently stands.

I have said before; I am *not* going to make KB vs. KiB a
metaconfiguration option -- that would defeat the whole purpose of
having standard terminology.  That decision is final, and this subject
is closed.

The other is not a bad idea in principle.  I've thought before about
adding a feature that would add specified boilerplate to the help a
tristate symbol, for exactly the reasons you suggest.  Three things make
it a bit messy in practice.

One is that it would have to be expressed in the rulebase, ruther than
wired into the code.  I will not hardwire specific knowledge about
the Linux-specific properties of tristate symbols into the CML2 engine.
CML2 is already being used by at least two projects other than the kernel
and I know of a third that has it under consideration.  Therefore I must
preserve its generality.

The second problem is that the module boilerplate is not all
boilerplate.  Most instances contain the name of the generated module
object file.  Thus, ypo do this right, I would have to declare module
names in the rulebase, one for each tristate entry.  This implies a
significant extension to the CML2 language, which I'm reluctant to do
right now.  The design is stable.  I want it to stay that way until
(at least) well after CML2 achieves acceptance.

Third, I don't want to do major surgery on Configure.help until after
CML2 enters the tree.  Were I to do so, I would then have to maintain
two different versions of Configure.help.  That would be too big a pain.

Therefore, I'm going to defer consideration of this feature for now.
I certainly will not consider it until after CML2 goes into the 2.5 tree,
and may not consider it until there is some kind of final decision on
a 2.4 backport.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

When only cops have guns, it's called a "police state".
        -- Claire Wolfe, "101 Things To Do Until The Revolution" 
