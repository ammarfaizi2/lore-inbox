Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVAGPe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVAGPe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVAGPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:34:28 -0500
Received: from styx.suse.cz ([82.119.242.94]:51087 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261459AbVAGPeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:34:23 -0500
Date: Fri, 7 Jan 2005 16:35:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Lion Vollnhals <webmaster@schiggl.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050107153534.GA4020@ucw.cz>
References: <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org> <20050104214315.GB1520@elf.ucw.cz> <41DC0E70.4000005@schiggl.de> <20050106222927.GC25913@elf.ucw.cz> <s5hoeg1wduz.wl@alsa2.suse.de> <20050107135418.GB1405@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107135418.GB1405@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:54:18PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > I have a problem with net-devices, ne2000 in particular, in 2.6.9 and 
> > > > 2.6.10, too. After a resume the ne2000-device doesn't work anymore. I 
> > > > have to restart it using the initscripts.
> > > > 
> > > > How do I add suspend/resume support (to ISA devices, like my ne2000)?
> > > > Can you point me to some information/tutorial?
> > > 
> > > Look how i8042 suspend/resume support is done and do it in similar
> > > way...
> > 
> > Yep it's fairly easy to implement in that way (I did for ALSA).
> > 
> > But i8042 has also pm_register(), mentioning about APM.  Isn't it
> > redundant?
> 
> Yes, it looks redundant. Vojtech, could you check why this is still
> needed? It should not be.
 
We already have a patch removing that in the queue.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
