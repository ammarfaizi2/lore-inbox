Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVBSQvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVBSQvn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVBSQvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:51:43 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:13785 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261725AbVBSQvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:51:41 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <9e47339105021907561c4f408c@mail.gmail.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
	 <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
	 <9e47339105021907561c4f408c@mail.gmail.com>
Date: Sat, 19 Feb 2005 16:51:01 +0000
Message-Id: <1108831861.4085.172.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: Hotplug blacklist and video devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 10:56 -0500, Jon Smirl wrote:

> I didn't say make framebuffer depend on DRM, you can still unload DRM
> before suspend.  It's the other way around DRM needs framebuffer.
> Suspend/resume are part of this. In the current model there is no way
> for the DRM driver to see the suspend/resume events. I haven't tried
> it but I suspect a suspend/resume with DRM running has a bad outcome
> right now.

Right. But for most machines, it's not possible to successfully resume
if an accelerated framebuffer driver is loaded. Until that's fixed,
tying DRM functionality to the framebuffer will make it impractical to
use DRM on laptops. That's a regression from the current situation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

