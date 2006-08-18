Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWHRRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWHRRoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHRRoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:44:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:56946 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751440AbWHRRoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:44:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=D6DLgzU+JbdI6GnVRCf1yWSxFyOF3UI5fkOnKkN3SzettVsBcvt2YgOEblGSqzpwNAaxZUwVM2hwSYYM7gAIjYpiodWW4SaMLBjVhm8mzWXprDi0CpP2R6j3qZSro7INHIWgvstIHwO4fd/zvU94fhbmODVYBBolaY94Yvlo8Dg=
Date: Fri, 18 Aug 2006 19:43:52 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       airlied@linux.ie, Jaroslav Kysela <perex@suse.cz>
Subject: Re: oops while loading snd-seq-oss (was: Re: 2.6.18-rc4-mm1 BUG, drm related)
Message-ID: <20060818194352.GC720@slug>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060815130345.GA3817@slug> <20060815071632.b10d3a03.akpm@osdl.org> <20060815173726.GA2533@slug> <20060815092146.f8a6942a.akpm@osdl.org> <20060818111118.GB1586@slug> <20060818085220.2f679f9c.akpm@osdl.org> <s5hsljuyr1h.wl%tiwai@suse.de> <20060818184411.GA720@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818184411.GA720@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 06:44:11PM +0000, Frederik Deweerdt wrote:
> On Fri, Aug 18, 2006 at 05:58:18PM +0200, Takashi Iwai wrote:
> > At Fri, 18 Aug 2006 08:52:20 -0700,
> > Andrew Morton wrote:
> > > 
> > Frederik, what hardware are you using?  Is it emu10k1?
> You'll find the lspci output, dmesg, .config at
> http://fdeweerdt.free.fr/drm_bug/, I mentioned it previously on the
> thread, but at that time I thought it was related with drm (I must have
> messed up with my bisection) so you weren't CC'd, sorry.
> 
Err, turns up I maybe was right with the bisection.  I think that the
drm patches mess my box in some way that it makes ALSA fail: I was
trying to load the modules by hand as you suggested, but the machine
rebooted instantaneously.
As I was about to retry, it occured to me that maybe this drm had
something to do after all and I tried shutting down the X server _before_
loading the ALSA modules: box freeze.

Now, the box is behaving OK (no oopses) with the DRI line commented in
the xorg.conf file. I'll try to narrow down which part of the DRM update
is causing such a strange behaviour. Sorry for the noise Takashi.

Regards,
Frederik
