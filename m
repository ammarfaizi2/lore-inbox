Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133017AbRDKWuJ>; Wed, 11 Apr 2001 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDKWt7>; Wed, 11 Apr 2001 18:49:59 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32727 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S133036AbRDKWtw>;
	Wed, 11 Apr 2001 18:49:52 -0400
Date: Wed, 11 Apr 2001 18:20:34 -0400
From: esr@thyrsus.com
To: davej@suse.de
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010411182034.A8733@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, davej@suse.de,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104101047.f3AAl0h07395@snark.thyrsus.com> <Pine.LNX.4.31.0104112013010.25121-100000@athlon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104112013010.25121-100000@athlon>; from davej@suse.de on Wed, Apr 11, 2001 at 08:43:57PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de <davej@suse.de>:
> One of the first things I noticed was it seems noticably slower
> than CML1. A make menuconfig in CML1 takes me into the menu
> in under a second. (On an already compiled tree).
> CML2 takes around 15 seconds before I get that far.
> This is on an Athlon 800 w/512MB. I dread to think how this
> responds on a 486.

Yes, I know I have some speed-tuning to do.

> Scrolling the cursor bar in menuconfig causes a lot of flickering
> as the entire screen seems to be redrawn. This is becomes unusable
> after a few minutes usage. Scrolling under CML1's menuconfig doesn't
> show this behaviour.

That's odd.  I see no screen flicker at all when I scroll my menu bar.
I wonder what's different about your environment.  You're running under
SuSE, I presume -- perhaps you have an older ncurses version?

> The various colours used to show submenus that have been visited
> seems confusing, and unnecessary. Their meaning also seems undocumented.

I'll document them.  They're intended to help you track what portions
of the configuration you've already done.
 
> Top level menu seems to have gained a few items.
> For example, the `SCSI support' item has disappeared,
> making `SCSI disk support' and `SCSI low-level drivers'
> both appear on the top level menu.

The SCSI support flag is in the buses menu.  You see these two menus because
the defconfig sets it on.
 
> For some reason, the kernel hacking menu doesn't show
> 4/5 of the options that it used to. Instead it replaces
> them with one new one (Disable VHPT). Which it seems to
> picking up from the IA64 tree. Most strange.

Ah.  That's because I didn't have an `unless ia64 suppress DISABLE_VHPT'
I've added that.

A lot of the stuff that used to be under that menu moved to archihacks,
I think.
 
> Finally, quitting the program (q twice) gives me this..
> python2 -O scripts/configtrans.py -h include/linux/autoconf.h -s .config
> config.out
> Traceback (most recent call last):
>   File "scripts/configtrans.py", line 104, in ?
>     sys.stderr.write(args[0]);
> TypeError: read-only character buffer, int
> make: *** [menuconfig] Error 1

I can't reproduce this.  Do you get the same behavior under 1.0.3?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Such are a well regulated militia, composed of the freeholders,
citizen and husbandman, who take up arms to preserve their property,
as individuals, and their rights as freemen.
        -- "M.T. Cicero", in a newspaper letter of 1788 touching the "militia" 
            referred to in the Second Amendment to the Constitution.
