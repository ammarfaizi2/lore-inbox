Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUJDAOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUJDAOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 20:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJDAOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 20:14:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12815 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268269AbUJDAOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 20:14:16 -0400
Date: Mon, 4 Oct 2004 02:13:39 +0200
From: Adrian Bunk <adrian.bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ed Sweetman <safemode@comcast.net>, preining@logic.at, edt@aei.ca,
       jeremy@goop.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-ID: <20041004001339.GD1948@stusta.mhn.de>
References: <1096787657.9182.6.camel@localhost> <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <200410021440.45194.edt@aei.ca> <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <20041002105038.GB2470@stusta.mhn.de> <20041003083014.GB12458@gamma.logic.tuwien.ac.at> <416084A5.4080200@comcast.net> <20041003162456.4729ab1a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003162456.4729ab1a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 04:24:56PM -0700, Andrew Morton wrote:
> Ed Sweetman <safemode@comcast.net> wrote:
> >
> > None of the mails reporting that inserting a header in any file has 
> >  produced a build here that actually gets rid of the build error.  I have 
> >  the same errors about implicit declarations of ack_APIC_irq that i had 
> >  before i added asm/io_apic.h to irq.c in arch/i386/kernel and before i 
> >  added it to include/asm/hardirq.h.   I've attached my .config to see if 
> >  anyone realizes what i'm doing wrong or what's not being defined 
> >  correctly.
> 
> yeah, it's all screwed up.  I fixed it up with the below two patches.
>...

After a quick grep it seems x86_64 and ia64 might require similar 
patches for at least APIC_MISMATCH_DEBUG?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

