Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTEFRaE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTEFRaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:30:04 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:2565 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263871AbTEFRaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:30:02 -0400
Date: Tue, 6 May 2003 18:42:10 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Andy Pfiffer <andyp@osdl.org>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5.69: Missing logo?
In-Reply-To: <1052241905.1238.3.camel@andyp.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0305061841280.7110-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is the reversal of the changes of cfbimgblit.c. It brought back this 
bug :-(

> On Tue, 2003-05-06 at 10:07, Russell King wrote:
> > Hi,
> > 
> > I seem to have a penguin missing in action, somewhere between 2.5.68 and
> > 2.5.69.  Has anyone else lost a penguin under similar circumstances?
> 
> Tux is AWOL for me, too.
> 
> bk/linux-2.5.69+kexec2> grep LOGO .config
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> bk/linux-2.5.69+kexec2> grep CONFIG_FB .config | grep =y
> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_FB_I810=y
> CONFIG_FB_I810_GTF=y
> bk/linux-2.5.69+kexec2> lspci | grep -i VGA
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
> (rev 85)
> bk/linux-2.5.69+kexec2>
> 
> 
> > $ grep LOGO linux-sa1100/.config
> > CONFIG_LOGO=y
> > # CONFIG_LOGO_LINUX_MONO is not set
> > CONFIG_LOGO_LINUX_VGA16=y
> > CONFIG_LOGO_LINUX_CLUT224=y
> > 
> > Other than the missing logo, the fb display looks as it did under 2.5.68.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

