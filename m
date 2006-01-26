Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWAZLtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWAZLtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWAZLtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:49:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750770AbWAZLtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:49:11 -0500
Date: Thu, 26 Jan 2006 12:48:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP alternatives
Message-ID: <20060126114858.GA1605@elf.ucw.cz>
References: <43D648CC.4090101@suse.de> <20060126102250.GA2790@elf.ucw.cz> <43D8AFC6.4010804@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D8AFC6.4010804@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 26-01-06 12:17:26, Gerd Hoffmann wrote:
> Pavel Machek wrote:
> > Hi!
> > 
> >> Can you include the patch in -mm to give it some testing?  Then merge
> >> maybe for 2.6.17?  Posted last time in december, with nobody complaining
> >> any more about the most recent version.  The patch is almost unmodified
> >> since, I've only had to add a small chunk due to the mutex merge.
> >> Description is below, the patch (against -rc1-git4 snapshot) is
> >> attached.
> > 
> > Well, I'm not 100% convinced this is really good idea.. It increases
> > complexity quite a lot.
> 
> Well, we have alternatives for quite some time already, this is just an
> extension of the existing bits ...

Like... during suspend we hot-unplug all but one cpu. Patching code at
that point is quite unneccessary...

> > Oh and please inline patches.
> 
> Whats wrong with "Content-Disposition: inline" attachments?  The risk
> they get whitespace-mangeled is much lower then.  Also mailers display
> them inline and also quote them on reply so you can easily comment them.
>  At least mutt and thunderbird do that.  If your mailer doesn't file a
> bug ;)

Consensus on lkml is to inline patches. Content-disposition: inline is
commonly accepted as not-too-evil, and my mailer (mutt) usually
honours that, but something in your mail tripped it.

								Pavel
-- 
Thanks, Sharp!
