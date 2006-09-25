Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWIYCWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWIYCWL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWIYCWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:22:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21257 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964813AbWIYCWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:22:10 -0400
Date: Mon, 25 Sep 2006 04:22:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, junkio@cox.net
Subject: Re: git diff <-> diffstat
Message-ID: <20060925022208.GF4547@stusta.de>
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org> <45172297.6070108@garzik.org> <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org> <20060925011436.GC4547@stusta.de> <Pine.LNX.4.64.0609241858380.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609241858380.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 07:05:39PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 25 Sep 2006, Adrian Bunk wrote:
> > 
> > Is there any way for "git diff" to handle additional options diffstat 
> > handles? I'm a big fan of the -w72 diffstat option.
> 
> No, I think we've got the width fixed at 80 columns.
> 
> > Oh, and with git 1.4.2.1,
> >   git diff -M --stat --summary v2.6.18..master
> > in your tree gives me some funny lines like:
> > 
> >  .../netlabel/draft-ietf-cipso-ipsecurity-01.txt    |  791 +
> >  .../{cpu_setup_power4.S => cpu_setup_ppc970.S}     |  103 
> >  .../powerpc/platforms}/iseries/it_exp_vpd_panel.h  |    6 
> >  .../powerpc/platforms}/iseries/it_lp_naca.h        |    6 
> > 
> > I don't know what's going wrong here, but diffstat doesn't produce this.
> 
> Nothing is going wrong, and diffstat doesn't produce it, exactly because 
> diffstat cannot understand renames.
>...
> With long path-names, it can get a bit confusing, since we then truncate 
> the end result and just show the last parts to make it fit, of course.
>...

Ah, OK. The truncates are something I wasn't used from diffstat 
(diffstat always prints the complete name).



> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

