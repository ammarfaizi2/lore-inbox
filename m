Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752344AbWKLSjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbWKLSjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbWKLSjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:39:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61197 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752344AbWKLSjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:39:39 -0500
Date: Sun, 12 Nov 2006 18:39:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
Message-ID: <20061112183927.GB5081@ucw.cz>
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com> <20060918100548.GJ3746@elf.ucw.cz> <450E771E.1070207@gmail.com> <20061106135751.GA13517@elf.ucw.cz> <454F747A.9050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454F747A.9050209@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >and I do not see powersave tunable:
> >
> >root@amd:/sys/module# ls libata/parameters/
> >ata_probe_timeout         atapi_enabled 
> >hotplug_polling_interval
> >atapi_dmadir              fua
> >
> >...how do I pull working version?
> 
> I haven't updated link powersave patch yet.  Core 
> implementation was agreed on but interface hasn't been 
> decided yet.  Maybe it's about time to add 
> /sys/class/ata_{host|device}/.  So, the patchset is 
> pushed back for the time being.

/sys/class/ata* would probably be ok.

> >Well... things are pretty quiet in that area just 
> >now... So yes.
> 
> If I understood correctly, the high power consumption of 
> ahci controller can be solved by dynamically turning off 
> command processing while the controller is idle, which 
> fits nicely into link powersaving, right?  So, I think 
> full-fledged leveled dynamic PM would be an overkill for 
> this particular problem, but then again, maybe the 

It is single bit, and it should not even need a timeout, AFAICT, so
perhaps we should just fix it (no need for dynamic PM layers). It
probably does not even need to be configurable...

-- 
Thanks for all the (sleeping) penguins.
