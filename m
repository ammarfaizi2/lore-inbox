Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287008AbSABWCz>; Wed, 2 Jan 2002 17:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286853AbSABWCr>; Wed, 2 Jan 2002 17:02:47 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:51331
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284886AbSABWB1>; Wed, 2 Jan 2002 17:01:27 -0500
Date: Wed, 2 Jan 2002 16:47:57 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102164757.A16976@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102163043.A16513@thyrsus.com> <Pine.LNX.4.33.0201022247470.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201022247470.427-100000@Appserv.suse.de>; from davej@suse.de on Wed, Jan 02, 2002 at 10:48:28PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> > Consider the lives of people administering large server farms or
> > clusters.  Their hardware is not necessarily homogenous, and the
> > ability to query the DMI tables on the fly could be useful both
> > for administration and automatic process migration.
> 
> Given that 'dmidecode' works fine in those circumstances, that's still
> not a convincing argument imo.

But only for people and programs with root privileges.  It all turns
then, on whether we want to insist that all software doing hardware 
probing must have root privileges to function.

I submit that the answer is "no" -- the right direction, for security
and other reasons, is to make *fewer* capabilities dependent on root
privileges rather than more, and to reject design approaches that
imply creating more suid programs to give ordinary users capabilities
that involve only *reading* config information.

There is already stuff in /proc that seems to be there for precisely this
reason.  So /proc/dmi would hardly be a violation of norms.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Everything that is really great and inspiring is created by the
individual who can labor in freedom.
	-- Albert Einstein, in H. Eves Return to Mathematical Circles, 
		Boston: Prindle, Weber and Schmidt, 1988.
