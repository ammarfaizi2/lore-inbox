Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbTDVVzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDVVze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:55:34 -0400
Received: from dsl254-126-114.nyc1.dsl.speakeasy.net ([216.254.126.114]:25034
	"EHLO Chumak.ny.ranok.com") by vger.kernel.org with ESMTP
	id S263881AbTDVVzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:55:33 -0400
Message-ID: <3EA5BD28.6EC9EEE6@ranok.com>
Date: Tue, 22 Apr 2003 18:07:36 -0400
From: Vagn Scott <vagn@ranok.com>
Organization: vDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i586)
X-Accept-Language: en, no, uk
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: [2.5.68] no console messages after switch to FB (matrox
References: <14D3CAA578B@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> > CONFIG_FB=y
> > CONFIG_FB_VESA=y
> > CONFIG_VIDEO_SELECT=y
> > CONFIG_FB_MATROX=y
> 
> Are you sure that your boot messages are directed to the matroxfb and
> not to the vesa?
> 
> In the past keyword for selecting matroxfb options was 'video=matrox:...',
> while now it is 'video=matroxfb:...', so you may have to modify your
> lilo.conf line (and do not ask me why these two letters were added if
> we have video= prefix... I do not know).

Adding video=matroxfb did the trick.  Thanks for the tip.

I still don't understand the logic of it, though.
If the kernel can find the resources to present the logo,
why can't it just keep using those resources for the rest
of the boot?

char *foo = find_a_home_for_tux();
if(foo) {
	logo_logo_logo(foo);
	keep_on_booting_baby(foo);
}
else {
	boot_or_die_trying("blinkenlights_n_beeperen");
}


what's next, rootname=/?

-- 
         _~|__
   >@   (vagn(     /
    \`-ooooooooo-'/
  ^^^^^^^^^^^^^^^^^^^^^^ The best pearls come from happy oysters. ^^^^^
