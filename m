Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVFNBwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVFNBwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVFNBwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:52:13 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:48134 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261341AbVFNBwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:52:07 -0400
Message-ID: <42AE453B.4050507@tuxrocks.com>
Date: Mon, 13 Jun 2005 20:47:23 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net
Subject: Re: [PATCH 1/4] new timeofday core subsystem (v. B2)
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
In-Reply-To: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> Hey Everyone,
> 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> current tree for testing. If there's no major issues on Monday, I'll re-
> diff against Andrew's tree and re-submit the patches for inclusion.

John,

I'm not sure what change caused this, but it seems that keyboard and
mouse interrupts are firing more than once when I'm using the c3tsc
timesource.  It manifests itself as multiple keypresses and odd mouse
tapping.  The problem seems to appear only in X, and it's definitely
confined to c3tsc (jiffies, pit, tsc-interp, and acpi_pm all seem to
work fine [1]).

[1] Note: Don't try to force-load the hpet timesource if you don't have
one, or if you aren't certain of the address :)

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCrkU7aI0dwg4A47wRAmfPAKCumk2XAILQ8tPEBWoawfmEmpUjTgCgz1k6
N50mf7Fnoha2nJmLOJ38Qt0=
=4bj2
-----END PGP SIGNATURE-----
