Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbUKCRuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUKCRuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKCRuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:50:39 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56276 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261793AbUKCRs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:48:58 -0500
Date: Wed, 3 Nov 2004 10:48:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: blaisorblade_spam@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
Message-ID: <20041103174856.GG381@smtp.west.cox.net>
References: <20041102232001.370174C0BC@zion.localdomain> <Pine.LNX.4.61.0411031747020.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411031747020.17266@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 05:56:46PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 3 Nov 2004 blaisorblade_spam@yahoo.it wrote:
> 
> > This has actually created not-working UML binaries (since UML is always
> > "cross-compiled" for this purpose), as reported by Julian Scheid.
> 
> This rather suggests, there is a problem with UML. Either fix your Kconfig 
> to prevent nonvalid configurations or detect and report the problem at 
> runtime.

No, this is a damn annoying kbuild problem when cross compiling.  It's
just nice that the UML folks run into this too and found a better fix
than deleting the /boot and /lib files from the list.

> > We all agreed on this kind of general, not UML-only fix, and I (Paolo)
> > implemented it.
> 
> I don't like the two separate lists, it would be easier to just skip all 
> absolute path names.
> I would also like to avoid this patch at all. If this really should be a 
> problem, I'd consider to don't run kconfig at all in this case if there 
> is no configuration and instead suggest running defconfig (or one of 
> machine specific config targets) first.

I have a feeling that changing the behavior of 'make {,x,g,q}config' to
fail if there's no .config will upset a lot of users, possibly even more
than would be upset by never looking in /boot or /lib ever.

-- 
Tom Rini
http://gate.crashing.org/~trini/
