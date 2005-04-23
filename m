Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVDWJPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVDWJPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 05:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVDWJPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 05:15:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13701 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261522AbVDWJPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 05:15:10 -0400
Date: Sat, 23 Apr 2005 11:14:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, rjw@sisk.pl,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Steinmetz <ast@domdv.de>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
Message-ID: <20050423091448.GA8015@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz> <42691498.7060003@suse.de> <d120d500050422195755c5b918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050422195755c5b918@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On 4/22/05, Stefan Seyfried <seife@suse.de> wrote:
> > --- linux/kernel/power/swsusp.c~        2005-04-22 17:07:56.000000000 +0200
> > +++ linux/kernel/power/swsusp.c 2005-04-22 17:09:22.000000000 +0200
> > @@ -1239,7 +1239,7 @@ static int check_sig(void)
> >                 */
> >                error = bio_write_page(0, &swsusp_header);
> >        } else {
> > -               printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
> > +               printk(KERN_ERR "swsusp: Suspend partition is no suspend image.\n");
> 
> Hrm, I don't think it is a good message... What about "Suspend
> partition has no suspend image" or, better yet, "Suspend partition
> does not contain valid suspend image"?

I settled with

                printk(KERN_INFO "swsusp: Suspend partition does not contain suspend image.\n");


										Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
