Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbTAHUuJ>; Wed, 8 Jan 2003 15:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267866AbTAHUuJ>; Wed, 8 Jan 2003 15:50:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14095 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267862AbTAHUuI>; Wed, 8 Jan 2003 15:50:08 -0500
Date: Wed, 8 Jan 2003 21:58:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] RE: kacpidpc needs to die
Message-ID: <20030108205848.GB32645@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A84725A10E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A10E@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > safe, anyway],
> > > kacpidpc needs to die. Andrew, are you going to kill it or 
> > should I do
> > > it?
> > 
> > I can kill it...let me just verify with you --
> > acpi_os_queue_for_execution has a two block switch statement, just use
> > the first block (the case that uses schedule_work) and delete 
> > the rest,
> > yes?
> 
> Oops, and combine acpi_os_schedule_exec and acpi_os_queue_exec, so that
> we call dpc->function() from the original thread. Anything else?

I don't see anything else, this looks okay.

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
