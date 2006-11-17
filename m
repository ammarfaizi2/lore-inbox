Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933691AbWKQQIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933691AbWKQQIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933690AbWKQQIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:08:21 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:5340 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S933688AbWKQQIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:08:20 -0500
Date: Fri, 17 Nov 2006 17:08:10 +0100
From: David Weinehall <tao@acc.umu.se>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117160810.GW14886@vasa.acc.umu.se>
Mail-Followup-To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <linux-acpi@vger.kernel.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org> <20061117153717.GU14886@vasa.acc.umu.se> <20061117154627.GA1544@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117154627.GA1544@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 03:46:27PM +0000, Matthew Garrett wrote:
> On Fri, Nov 17, 2006 at 04:37:17PM +0100, David Weinehall wrote:
> 
> > The fact that the dock starts to beep annoyingly. It has a button that
> > you should press before undocking, and wait for a green light to light
> > up before removing the laptop.  If you remove the computer without
> > doing so, the dock starts beeping, and it doesn't stop (AFAIK, haven't
> > managed to stand the beeping for more than 30 seconds or so) until you
> > replug the laptop.
> 
> Ah, hm. Interesting. Maybe it does want OS support, then. Have you tried 
> it in the Leading Brand OS?

Nope.

> > My guess is that there is some wait to trigger an undock event from
> > software as well, and that it would be nice to send that signal to the
> > dock before suspending...
> 
> You possibly don't want to do that if there's a mounted bay device in 
> the dock.

Well, right now I don't have a bay device in the dock, but refusing to
suspend in that case would be reasonable.  I need to add some hotplug
script for the bay device anyway if I add one.

> We really need to determine some sort of policy when it comes to mounted 
> devices that will potentially be removed by the user over 
> suspend/resume. Do we support this configuration (by not killing the 
> mount point), or do we prevent users from shooting themselves in the 
> foot?

Good question.  Personally I'd say we refuse to suspend when we have
devices we *know* to be dock-devices etc mounted.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
