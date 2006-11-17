Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755779AbWKQSSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbWKQSSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbWKQSSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:18:52 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:13812 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1754078AbWKQSSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:18:51 -0500
Date: Fri, 17 Nov 2006 19:18:42 +0100
From: David Weinehall <tao@acc.umu.se>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117181842.GX14886@vasa.acc.umu.se>
Mail-Followup-To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <linux-acpi@vger.kernel.org>
References: <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org> <20061117153717.GU14886@vasa.acc.umu.se> <20061117154627.GA1544@srcf.ucam.org> <20061117160810.GW14886@vasa.acc.umu.se> <20061117163128.GA2068@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117163128.GA2068@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:31:28PM +0000, Matthew Garrett wrote:
> On Fri, Nov 17, 2006 at 05:08:10PM +0100, David Weinehall wrote:
> 
> > Good question.  Personally I'd say we refuse to suspend when we have
> > devices we *know* to be dock-devices etc mounted.
> 
> Kernel-level or userspace? IBM certainly used to sell bay-mounted hard 
> drives, and while it's possible for a user to pull one out while the 
> machine is suspended, I suspect that the general use case is probably 
> for it to carry on being used.

I'd say that kind of policies should be left to userspace, since it's up
to userspace to decide if we suspend at all or not.  If the user tells
the kernel to shoot him in the foot, the kernel should take aim
carefully and turn him into a cripple.

> Possibly what's needed is something like Apple's nullfs - force unmount 
> the drive on suspend, and put a nullfs there instead. On resume, if the 
> drive is still there, remount it. If not, userspace applications get 
> upset about the missing drive but no data is lost. The downside to this 
> approach would be trying to figure out how to get the drive remounted 
> before the rest of userspace starts trying to scribble over it again...

Mmmm.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
