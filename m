Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289083AbSAIXop>; Wed, 9 Jan 2002 18:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSAIXog>; Wed, 9 Jan 2002 18:44:36 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:59031
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289083AbSAIXoa>; Wed, 9 Jan 2002 18:44:30 -0500
Date: Wed, 9 Jan 2002 18:29:02 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109182902.A2804@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Matthew Kirkwood <matthew@hairy.beasts.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020109174637.A1742@thyrsus.com> <Pine.LNX.4.33.0201092325280.31502-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201092325280.31502-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Wed, Jan 09, 2002 at 11:29:29PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood <matthew@hairy.beasts.org>:
> > We've been over this already.  No, the configurator user should *not*
> > have to su at any point before actual kernel installation.  Bad
> > practice, no doughnut.
> 
> Why bad practice?  Anyway, you can:
> 
> 	if [ /proc/ -nt /var/run/dmidecode ]; then
> 		echo We need to run some code as root.
> 		echo -n Enter root\'s\
> 		su -c 'dmidecode > /var/run/dmidecode'
> 	fi
> 
> Which provides at least a way to have your config tool
> work without having to bloat the initramfs.

OK.  One more time.

The autoconfigurator is *not* mean to be run at boot time, or as root.

It is intended to be run by ordinary users, after system boot time.
This is so they can configure and experimentally build kernels without
incurring the "oops..." risks of going root.

Therefore, the above 'solution' is not acceptable.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A man who has nothing which he is willing to fight for, nothing 
which he cares about more than he does about his personal safety, 
is a miserable creature who has no chance of being free, unless made 
and kept so by the exertions of better men than himself. 
	-- John Stuart Mill, writing on the U.S. Civil War in 1862
