Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVBPBl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVBPBl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVBPBl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:41:27 -0500
Received: from 83-216-143-24.alista342.adsl.metronet.co.uk ([83.216.143.24]:29631
	"EHLO devzero.co.uk") by vger.kernel.org with ESMTP id S261963AbVBPBlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:41:22 -0500
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: Lorenzo Colitti <lorenzo@colitti.com>
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 01:41:11 +0000
User-Agent: KMail/1.7.1
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <1108500194.12031.21.camel@elrond.flymine.org> <42126506.8020407@colitti.com>
In-Reply-To: <42126506.8020407@colitti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502160141.11633.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Feb 2005 21:09, Lorenzo Colitti wrote:
[snip]
> I would advise trying to compile a custom kernel from scratch with my
> .config first.
>
> I got S3 working first with a very basic kernel config, but I couldn't
> get it to work with my usual kernel. Assuming it was some feature that
> caused the problem, I started disabling features in the hope of getting
> it to work, but I ended up with two different kernels with seemingly
> irrelevant differences, of which one would succesfully resume and one
> wouldn't. So I started added features to the other kernel, and I never
> found out what caused the problem.

I took your advice and built your kernel with a few modifications (XFS instead 
of ext, etc.). If I boot the kernel with init=/bin/sh, I can actually 
suspend! Thanks!

I will exhaustively enable and disable drivers tomorrow to figure out which 
one is causing suspend to fail when I do a complete boot. Whatever we find is 
clearly a bug that should be fixed.

It is not the framebuffer driver (I always ran without vesafb or radeonfb), 
and it is not my ipw2200 or USB drivers.

Also, is USB suspend/resume supposed to work? My brief trials involved 
modprobing the USB HCD modules, which still allowed me to suspend/resume, but 
my USB mouse was non-functional on resume.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
