Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWIYBOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWIYBOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWIYBOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:14:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64776 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932196AbWIYBOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:14:38 -0400
Date: Mon, 25 Sep 2006 03:14:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, junkio@cox.net
Subject: git diff <-> diffstat
Message-ID: <20060925011436.GC4547@stusta.de>
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org> <45172297.6070108@garzik.org> <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 05:34:05PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 24 Sep 2006, Jeff Garzik wrote:
> > 
> > Right now I just pipe 'git diff master..branch' to diffstat.
> 
> Ok. That just means that you can change it do say
> 
> 	git diff -M --stat --summary master..branch
> 
> and you get exactly what you need. No need for a separate diffstat at all, 
> and you get all the renaming and summary printout.

Is there any way for "git diff" to handle additional options diffstat 
handles? I'm a big fan of the -w72 diffstat option.

Oh, and with git 1.4.2.1,
  git diff -M --stat --summary v2.6.18..master
in your tree gives me some funny lines like:

 .../netlabel/draft-ietf-cipso-ipsecurity-01.txt    |  791 +
 .../{cpu_setup_power4.S => cpu_setup_ppc970.S}     |  103 
 .../powerpc/platforms}/iseries/it_exp_vpd_panel.h  |    6 
 .../powerpc/platforms}/iseries/it_lp_naca.h        |    6 

I don't know what's going wrong here, but diffstat doesn't produce this.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

