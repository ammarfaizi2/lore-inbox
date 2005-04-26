Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVDZGiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVDZGiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDZGiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:38:06 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:30892 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261354AbVDZGhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:37:32 -0400
Date: Tue, 26 Apr 2005 02:33:28 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426063328.GD3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
	Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
	USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz> <1114486761.7183.14.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114486761.7183.14.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 01:39:20PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Yes.
> > 
> > I believe it should just do suspend(PMSG_SUSPEND) before system
> > shutdown. If you think distintion between shutdown and suspend is
> > important (I am not 100% convinced it is), we can just add flag
> > saying "this is system shutdown".
> > 
> > Actually this patch should be in the queue somewhere... We had it in
> > suse trees for a long time, and IMO it can solve problem easily.
> 
> I think we probably want a distinct state for shutdown ...
> 
> Ben.

Yes, it's possible we do.  I'm not sure what every platform requires.  The
question is should we make this change to pm_message_t in the short term?
"->shutdown", even though incorrect, seems to fill this role.

Greg, have you seen shutdown methods doing anything special other than
standard "->suspend" stuff?

Thanks,
Adam
