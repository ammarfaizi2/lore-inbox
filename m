Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTBENqi>; Wed, 5 Feb 2003 08:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTBENpe>; Wed, 5 Feb 2003 08:45:34 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1796 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261302AbTBENp2>;
	Wed, 5 Feb 2003 08:45:28 -0500
Date: Tue, 4 Feb 2003 23:10:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: ducrot@poupinou.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Message-ID: <20030204221003.GA250@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch is for s4bios support in 2.5.59 with acpi-20030123.
> > 
> > This is the 'minimal' requirement.  Some devices (especially the
> > IDE part) are not well resumed.  Handle with care..
> > 
> > Note also that the resuming part (I mean IDE) was more stable
> > with an equivalent patch when I tested with 2.5.54 (grumble 
> > grumble)...
> > 
> > I think also that it is a 'good' checker for devices power management
> > in general...
> 
> I'd really rather just have S4OS (aka swsusp) in 2.5 patches -- if the
> OS can do S4 on its own, that is really preferable to S4bios.

Well, we already have S4OS, and having S4OS does not mean we can't
have S4bios.

Some people apparently want slower suspend/resume but have all caches
intact when resumed. Thats not easy for swsusp but they can have that
with S4bios. And S4bios is usefull for testing device support; it
seems to behave slightly differently to S3 meaning better testing.

If you already have hibernation partition from factory, which you are
using anyway for w98, S4bios is easier to use and more foolproof
(i.e. you can't boot into wrong kernel which does not resume but does
fsck instead).

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
