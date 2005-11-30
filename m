Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVK3MDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVK3MDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 07:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVK3MDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 07:03:37 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:1871 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751171AbVK3MDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 07:03:36 -0500
Date: Wed, 30 Nov 2005 13:03:32 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jbglaw@lug-owl.de, torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
Message-ID: <20051130120332.GA5316@harddisk-recovery.com>
References: <20051128170414.GA10601@harddisk-recovery.nl> <20051129133042.6d344110.akpm@osdl.org> <20051129203622.GA17053@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129203622.GA17053@mars.ravnborg.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 09:36:22PM +0100, Sam Ravnborg wrote:
> > 
> > 
> > I already have the below queued up, which is a bit different.  Does it work
> > OK?
> 
> Brian's version preserve EXTRANAME, but I have not seen it
> used/documented anywhere?

It isn't used anywhere:

erik@zurix:~/git/linux-2.6 > find . -name Kconfig | xargs grep EXTRANAME
[nothing]

If there is a use for EXTRANAME, it should be included in the
KERNELRELEASE variable in the top level Makefile. As long as all
package scripts use the KERNELRELEASE variable, everything will be
fine.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
