Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270799AbTG0OEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270797AbTG0OEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:04:23 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46347 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270806AbTG0ODX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:03:23 -0400
Date: Sun, 27 Jul 2003 16:18:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stoian Atanasov <stoian@ucc.uni-sofia.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling problem with certain options
Message-ID: <20030727141835.GA944@mars.ravnborg.org>
Mail-Followup-To: Stoian Atanasov <stoian@ucc.uni-sofia.bg>,
	linux-kernel@vger.kernel.org
References: <bg07jn$t1g$1@main.gmane.org> <6usmosz19k.fsf@zork.zork.net> <bg0lvc$7nj$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bg0lvc$7nj$1@main.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 05:01:18PM +0300, Stoian Atanasov wrote:
> 
> Funny, but now i did the menuconfig again and clear, dep, bzImage, modules
> and it is ok, maybe i missed removing some module before as i want to
> compile a quite light kernel.

make dep is obsolete in 2.6

> Many times i wanted to compile a kernel with just a fiew options and get
> some errors, and when want to kompile with lot of options it's ok. I guess
> there are some dependency problems, which are not handled properly by make
> dep? And i heard somewhere that it is a common error.

When reconfiguring a 2.4 kernel it is adviced to do a:
cp .config ..
make mrproper
cp ../.config .
make oldconfig
make dep
etc.

For 2.6 you can just run make, without cleaning up before.
To get a resonable small configuration you can start out with
"make allnoconfig", which compiles ok in 2.6 for now.

> Is there a dedicated site, forum about this problem?

This is a good place - you can also try kernelnewbies.

	Sam
