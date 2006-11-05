Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932753AbWKEX3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbWKEX3v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWKEX3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:29:51 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:52128 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S932748AbWKEX3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:29:50 -0500
Date: Mon, 6 Nov 2006 00:29:44 +0100
From: David Weinehall <tao@acc.umu.se>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061105232944.GA23256@vasa.acc.umu.se>
Mail-Followup-To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <linux-acpi@vger.kernel.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102175403.279df320.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 05:54:03PM -0800, Kristen Carlson Accardi wrote:
> On Wed, 1 Nov 2006 12:56:18 +0100
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> > info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> > (-mm1 behaves the same).
> > 									Pavel
> > -- 
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
> PCI Root Bridge whenever the lid opens up.
> 
> There is a bug here in that acpiphp shouldn't even be used on the X60 -
> it has no hotpluggable slots.

How about the docking station?


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
