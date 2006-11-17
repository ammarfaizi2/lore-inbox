Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424809AbWKQPhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424809AbWKQPhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424805AbWKQPhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:37:24 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:1750 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1424793AbWKQPhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:37:23 -0500
Date: Fri, 17 Nov 2006 16:37:17 +0100
From: David Weinehall <tao@acc.umu.se>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117153717.GU14886@vasa.acc.umu.se>
Mail-Followup-To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <linux-acpi@vger.kernel.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117151341.GA1162@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 03:13:41PM +0000, Matthew Garrett wrote:
> On Fri, Nov 17, 2006 at 11:22:38AM +0100, David Weinehall wrote:
> 
> > That was with 2.6.17; with 2.7.19-pre? (don't remember right now),
> > docking seems to work without acpiphp.  It still would be nice to be
> > able to undock when the laptop is sleeping though; how do I achieve
> > that?
> 
> My experience of most laptops is that they'll fire off a bus check 
> notification when you resume, so as long as nothing actually tries to 
> access the hardware before that's handled, everything should be fine. 
> What currently breaks when you undock while asleep?

The fact that the dock starts to beep annoyingly. It has a button that
you should press before undocking, and wait for a green light to light
up before removing the laptop.  If you remove the computer without
doing so, the dock starts beeping, and it doesn't stop (AFAIK, haven't
managed to stand the beeping for more than 30 seconds or so) until you
replug the laptop.

My guess is that there is some wait to trigger an undock event from
software as well, and that it would be nice to send that signal to the
dock before suspending...


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
