Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274876AbTGaV0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274877AbTGaV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:26:12 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:24359
	"EHLO gaston") by vger.kernel.org with ESMTP id S274876AbTGaV0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:26:09 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030731094904.GC464@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
	 <20030731094904.GC464@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059686717.2418.156.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 23:25:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 11:49, Pavel Machek wrote:
> Hi!
> 
> >  - APM uses the pm_*() calls for a vetoable check,
> >    never issues SAVE_STATE, then goes POWER_DOWN.
> 
> I remember the reason... SAVE_STATE expects user processes to be
> stopped, which is not the case in APM. Perhaps that is easy to fix
> these days...

No ! You may feel better stopping user processes (and actuallty you
may require that for swsusp, I don't know) but the whole PM scheme is
designed to make that unnecessary. I do NOT stop user processes on
suspend-to-RAM on PowerMacs, I don't think neither APM nor ACPI need
that (I may be wrong here, but if that is the case, then some drivers
need fixing).

Ben.

