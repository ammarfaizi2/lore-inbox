Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937229AbWLFTN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937229AbWLFTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937202AbWLFTN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:13:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56667 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937201AbWLFTNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:13:54 -0500
Date: Wed, 6 Dec 2006 19:13:51 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: Display class
In-Reply-To: <20061206105724.cf7b39bc.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612061859320.28745@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
 <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
 <20061205171401.fd11160d.randy.dunlap@oracle.com>
 <Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
 <20061206101434.8acb229a.randy.dunlap@oracle.com>
 <Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
 <20061206105724.cf7b39bc.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > That patch was rought draft for feedback. I applied your comments. This 
> > > > patch actually works. It includes my backlight fix as well.
> > > 
> > > Glad to hear it.  I had to make the following changes
> > > in order for it to build.
> > > However, I still have build errors for aty.
> > 
> > Ug. I see another problem. I had backlight completly compiled as a 
> > module! Thus it hid these compile errors. So we need also a 
> > CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE check as well. Can sysfs handle this 
> > well or would it be better the the backlight class be a boolean instead?
> 
> SCSI works as a module and it uses sysfs.
> See drivers/scsi/scsi_sysfs.c.
> Does that answer your question?  I wasn't quite sure what
> the question was.

I'm scratching my head on how to configure a modular driver and 
two modular sysfs classes. 
 
> Next question, based on:
> drivers/built-in.o: In function `probe_edid':
> (.text.probe_edid+0x42): undefined reference to `fb_edid_to_monspecs'
> 
> Should backlight and/or display support depend on
> CONFIG_FB?  Right now they don't, so the above can happen...

I already sent a patch to Andrew to make backlight/lcd work independent of
CONFIG_FB. Display is still in the alpha stage. In time it will work 
independent of CONFIG_FB.

