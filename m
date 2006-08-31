Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWHaSBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWHaSBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWHaSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:01:18 -0400
Received: from xenotime.net ([66.160.160.81]:50126 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932425AbWHaSBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:01:18 -0400
Date: Thu, 31 Aug 2006 11:04:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Message-Id: <20060831110436.995bdf93.rdunlap@xenotime.net>
In-Reply-To: <s5h8xl52h52.wl%tiwai@suse.de>
References: <20060831123706.GC3923@elf.ucw.cz>
	<s5h8xl52h52.wl%tiwai@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 15:01:45 +0200 Takashi Iwai wrote:

> At Thu, 31 Aug 2006 14:37:06 +0200,
> Pavel Machek wrote:
> > 
> > @@ -271,8 +272,8 @@ struct azx_dev {
> >  	/* for sanity check of position buffer */
> >  	unsigned int period_intr;
> >  
> > -	unsigned int opened: 1;
> > -	unsigned int running: 1;
> > +	unsigned int opened :1;
> > +	unsigned int running :1;
> >  };
> >  
> >  /* CORB/RIRB */
> > @@ -330,8 +331,8 @@ struct azx {
> >  
> >  	/* flags */
> >  	int position_fix;
> > -	unsigned int initialized: 1;
> > -	unsigned int single_cmd: 1;
> > +	unsigned int initialized :1;
> > +	unsigned int single_cmd :1;
> >  };
> 
> Any official standard reference for bit-field expressions?

Pavel knows how to submit patches to CodingStyle too.  :)

> >  /* driver types */
> > @@ -642,14 +643,14 @@ static int azx_reset(struct azx *chip)
> >  	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
> >  
> >  	count = 50;
> > -	while (! azx_readb(chip, GCTL) && --count)
> > +	while (!azx_readb(chip, GCTL) && --count)
> >  		msleep(1);
> 
> Hm, it looks rather like a personal preference.
> IMHO, it's harder to read without space...

We have been tending toward not using space in cases like this
(in my unscientific memory-based survey).

So, just this morning I have seen questions and opinions about
the following that could (or could not) use more documentation
or codification and I'm sure that we could easily find more,
but do we want to codify Everything??


1.  Kconfig help text should be indented (it's not indented in the
	GFS2 patches)

2.  if (!condition1)	/* no space between ! and condition1 */

3.  don't use C99-style // comments

4.  unsigned int bitfield :<nr_bits>;


---
~Randy
