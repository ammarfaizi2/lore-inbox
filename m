Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSJ0MFd>; Sun, 27 Oct 2002 07:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSJ0MFd>; Sun, 27 Oct 2002 07:05:33 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:684 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262370AbSJ0MFc>;
	Sun, 27 Oct 2002 07:05:32 -0500
Date: Sun, 27 Oct 2002 12:11:34 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Peter L Jones <peter@drealm.org.uk>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: Linux 2.5.44-ac4
Message-ID: <20021027121134.GA17025@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Peter L Jones <peter@drealm.org.uk>, linux-kernel@vger.kernel.org,
	alan@redhat.com
References: <200210270925.07460@advent.drealm.org.uk> <200210271040.31765@advent.drealm.org.uk> <20021027125218.A21310@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027125218.A21310@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 12:52:18PM +0100, Dave Jones wrote:
 > [cc:'d back to l-k where this belongs]
 > 
 > On Sun, Oct 27, 2002 at 11:40:31AM +0100, Peter L Jones wrote:
 >  > The mce.c entries are excluded by "#ifdef CONFIG_X86_MCE".  For some reason, 
 >  > the entire subdirectory has been built but the processor-specific modules 
 >  > don't have any CONFIG_X86_MCE protection.  This one's beyond my skill even to 
 >  > attempt to fix.  I guess I'll turn on machine check exceptions...
 > 
 > Oops, it's broken if CONFIG_X86_MCE=n
 > Change arch/i386/kernel/cpu/Makefile line 16 to read
 > obj-$(CONFIG_X86_MCE)   +=  mcheck/
 > and it should be ok..

Actually you need to patch a half dozen other places too.
I'll cook up a patch later.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
