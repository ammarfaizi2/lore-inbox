Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbSLDM1y>; Wed, 4 Dec 2002 07:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSLDM1y>; Wed, 4 Dec 2002 07:27:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53256 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266453AbSLDM1x>; Wed, 4 Dec 2002 07:27:53 -0500
Date: Wed, 4 Dec 2002 12:35:17 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021204123517.A3563@flint.arm.linux.org.uk>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021204115819.GB1137@gallifrey>; from gilbertd@treblig.org on Wed, Dec 04, 2002 at 11:58:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:58:19AM +0000, Dr. David Alan Gilbert wrote:
> Don't forget that ia64, x86-64 and s390 are all potentially growing
> users of Linux.  Linux on ARM, MIPS and PPC also has a healthy band of
> productive (commercial and home) users.

ARM Linux still has rather a large patch, but it is gradually getting
smaller again as things get merged.

As far as keeping the bits that are in Linus' kernel buildable (and
working), it is easier with the various BK cset patches or BK itself
because you can always be on top of Linus' tree.  However, there are
costs here:

1. An incompatible change can be merged at any time into Linus' tree,
   so frequent testing is required - might need a build system that
   automatically builds Linus' kernels for an architecture nightly.

2. As a result of (1), even if it built at the last test, that's no
   guarantee that the patch Linus releases will work - changes have
   appeared around the time of the release which break architecture
   code.

I would like to setup an automatic nightly ARM kernel build of the
current BK tree for multiple ARM machine types to get as much code
build-tested as possible.

However, this currently isn't feasible for me since most of the machines
here (except server + firewall) get powered off at night, and the remote
x86 boxen I've used in the past for occasional build testing are now under
a relatively heavy FTP (vsftp), rsync and web load and would severely
suffer from BK's consistency checks (l/a 0.91 1.32 1.76, blocks
in: ~2500 blocks/sec average.)

On bugme stuff, if you've submitted any ARM related bugs, I haven't had
any notifications from bugzilla about them (so I've not looked at bugme
since talking to Manfred.  Maybe Manfred missed settings things up.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

