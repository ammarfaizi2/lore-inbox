Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288411AbSADAQc>; Thu, 3 Jan 2002 19:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288412AbSADAQV>; Thu, 3 Jan 2002 19:16:21 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:38539
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288411AbSADAQM>; Thu, 3 Jan 2002 19:16:12 -0500
Date: Thu, 3 Jan 2002 19:02:19 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: anderson@metrolink.com, hch@caldera.de, lsb-discuss@lists.linuxbase.org,
        lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020103190219.B27938@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Joerg Schilling <schilling@fokus.gmd.de>, anderson@metrolink.com,
	hch@caldera.de, lsb-discuss@lists.linuxbase.org,
	lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
In-Reply-To: <200201032355.g03Ntx911860@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201032355.g03Ntx911860@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Fri, Jan 04, 2002 at 12:55:59AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.gmd.de>:
> The way /proc works has been introduced by Plan 9 in the first half
> of the 80s.  What Linux added as an abuse of the /proc filesytem in
> principle is a Plan 9 idea too. It makes sense to have something
> similar, but please please _not_ inside the /proc tree.
> 
> Sun is planning to have /sys with similar backgound in a future
> version of Solaris so it wouls make sense to talk to the Solaris
> kernel kackers to have a common way to go for the new /sys tree.

Well, hell.  If the "/proc is a blight on the face of the planet" ranting that
I've been hearing is just about the *name* /proc, then let's separate the
name issue from the content issue.

The kind of non-per-process information that is now in /proc needs to still
be there for many purposes; autoconfiguration is the one that is bugging 
me right now, but cluster management is just as important.

If moving /proc/cpuinfo to /sys/cpuinfo means people will stop trying to make
the cpuinfo information go away, then By all means let's move it.

I want /sys/dmi, too.

I'm willing to write up a proposal for /sys that would migrate the `unclean'
/proc stuff over to ./sys, and I'm willing to write the kernel patches to
implement the renaming.

I'm motivated to attack this right now because it touches the work I'm
doing on kernel autoconfiguration.

(Copied to the linux-kernel mailing list because of a parallel argument
happening there...)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The common argument that crime is caused by poverty is a kind of
slander on the poor.
	-- H. L. Mencken
