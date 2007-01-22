Return-Path: <linux-kernel-owner+w=401wt.eu-S1751929AbXAVFTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbXAVFTt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 00:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbXAVFTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 00:19:49 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:34153 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbXAVFTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 00:19:49 -0500
Subject: Re: Suspend to RAM generates oops and general protection fault
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B448BA.70800@usherbrooke.ca>
References: <45B422D3.9040409@usherbrooke.ca>
	 <1169436221.2190.13.camel@nigel.suspend2.net>
	 <45B448BA.70800@usherbrooke.ca>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 16:19:45 +1100
Message-Id: <1169443185.2190.16.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2007-01-22 at 16:16 +1100, Jean-Marc Valin wrote:
> >> I just encountered the following oops and general protection fault
> >> trying to suspend/resume my laptop. I've got a Dell D820 laptop with a 2
> >> GHz Core 2 Duo CPU. It usually suspends/resumes fine but not always. The
> >> relevant errors are below but the full dmesg log is at
> >> http://people.xiph.org/~jm/suspend_resume_oops.txt and my config is in
> >> http://people.xiph.org/~jm/config-2.6.20-rc5.txt
> ...
> > It looks like something is stomping on memory it shouldn't be touching,
> > so I would suggest testing multiple cycles with a minimal (preferably
> > zero) number of modules loaded. If that looks good and reliable, add
> > modules & processes until you can say 'If I do X, it breaks.'. If having
> > a minimal number of modules loaded doesn't help, I would then suggest
> > reviewing your kernel config to see if other things can be built as
> > modules and the same logic applied. You can be reasonably sure that it
> > will be a device driver. Common causes of suspend/resume problems from
> > the list you give below are acpi modules, bluetooth and usb. I'd also be
> > consider pcmcia, drm and fuse possibilities. But again, go for unloading
> > everything possible in the first instance.
> 
> Actually, the reason I sent this is that when I showed the oops/gpf to
> Matthew Garrett at linux.conf.au, he said it looked like a CPU hotplug
> problem and suggested I send it to lkml. BTW, with 2.6.20-rc5, the
> suspend to RAM now works ~95% of the time.

I agree that the second is cpu hotplug, but the first is something else,
hence my recommendations above.

Regards,

Nigel


