Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132976AbRDKTpa>; Wed, 11 Apr 2001 15:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132977AbRDKTpU>; Wed, 11 Apr 2001 15:45:20 -0400
Received: from ruthenium.btinternet.com ([194.73.73.138]:5612 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S132976AbRDKTpI>;
	Wed, 11 Apr 2001 15:45:08 -0400
Date: Wed, 11 Apr 2001 20:43:57 +0100 (BST)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: CML2 1.0.0 release announcement
In-Reply-To: <200104101047.f3AAl0h07395@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.31.0104112013010.25121-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Eric S. Raymond wrote:

> After 11 months of painstaking work and testing, CML2 1.0.0 is ready for use,
> and ready to replace the current kernel-configuration system.  You'll
> find it at <http://www.tuxedo.org/~esr/cml2/>.  I've made a transition
> guide available at <http://www.tuxedo.org/~esr/cml2/transition.html>.

Hi Eric,

 Out of curiosity, I decided to give CML2 a try this evening.
Some feedback:

One of the first things I noticed was it seems noticably slower
than CML1. A make menuconfig in CML1 takes me into the menu
in under a second. (On an already compiled tree).
CML2 takes around 15 seconds before I get that far.
This is on an Athlon 800 w/512MB. I dread to think how this
responds on a 486.

Scrolling the cursor bar in menuconfig causes a lot of flickering
as the entire screen seems to be redrawn. This is becomes unusable
after a few minutes usage. Scrolling under CML1's menuconfig doesn't
show this behaviour.

The various colours used to show submenus that have been visited
seems confusing, and unnecessary. Their meaning also seems undocumented.

Reporting of changing certain features seems to be excessive.
For example, changing CPU target from Pentium Pro to Athlon
tells me that "M686=n (deduced from MK7)"
Another confusing thing on this menu, happens when you select
CRUSOE, and then 386.
"MK7=n (deduced from M386) MCRUSOE=n (deduced from M386)"
Not sure why selecting Crusoe enables MK7.

Top level menu seems to have gained a few items.
For example, the `SCSI support' item has disappeared,
making `SCSI disk support' and `SCSI low-level drivers'
both appear on the top level menu.

For some reason, the kernel hacking menu doesn't show
4/5 of the options that it used to. Instead it replaces
them with one new one (Disable VHPT). Which it seems to
picking up from the IA64 tree. Most strange.

Finally, quitting the program (q twice) gives me this..
python2 -O scripts/configtrans.py -h include/linux/autoconf.h -s .config
config.out
Traceback (most recent call last):
  File "scripts/configtrans.py", line 104, in ?
    sys.stderr.write(args[0]);
TypeError: read-only character buffer, int
make: *** [menuconfig] Error 1


All the above was using an 2.4.3-ac4 tree, with CML2-1.0.0

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

