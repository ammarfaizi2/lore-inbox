Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314842AbSEKWOu>; Sat, 11 May 2002 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSEKWOt>; Sat, 11 May 2002 18:14:49 -0400
Received: from ns.suse.de ([213.95.15.193]:58894 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314842AbSEKWOs>;
	Sat, 11 May 2002 18:14:48 -0400
Date: Sun, 12 May 2002 00:14:47 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.15
Message-ID: <20020512001447.D30904@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	mochel@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200205112206.g4BM6Dp13365@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 06:06:13PM -0400, James Bottomley wrote:
 > This split is essentially the same as the one I did for 2.5.8 except that I've 
 > cleaned up setup_arch.h slightly (the other was, as I was told, "icky").  I 
 > didn't do any other alterations to setup.c because the projects list implies 
 > that Dave Jones and Patrick Mochel are going to be doing this, so I'll slide 
 > my changes in around this.

First batch of this work turned up in my tree in 2.5.14-dj2, seems to be
behaving well, so that should be going to Linus soon. With that out of
the way, (plus some other smaller split-up work like mtrr), the path
should be paved for x86 subarch support.

 > I've pulled visws.c out of i386/pci and put it in i386/visws.c, since it's 
 > really specific to visws and doing this also allows me to simplify the 
 > i386/pci/Makefile.

Sounds ok. visws is after all, an x86 subarch. Though we should probably
get some input from the folks who are actually still maintaining this
out-of-tree. I believe they have a project at sourceforge with newer
visws code than whats in mainline.

Other than Patricks work, and yours, the only other bits that are poking
arch/i386 anytime soon are probably ACPI and possibly some further
splitting up by one of the IBM folks whose name I've currently forgotten.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
