Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422838AbWJFSrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWJFSrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWJFSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:47:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16393 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422837AbWJFSrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:47:10 -0400
Date: Fri, 6 Oct 2006 20:47:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: 2.6.19-rc1 regression: airo suspend fails
Message-ID: <20061006184706.GR16812@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <871wpmoyjv.fsf@sycorax.lbl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871wpmoyjv.fsf@sycorax.lbl.gov>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 09:31:16PM -0700, Alex Romosan wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > so please give it a good testing, and let's see if there are any 
> > regressions.
> 
> it breaks suspend when the airo module is loaded:
> 
> kernel: Stopping tasks: =================================================================================
> kernel:  stopping tasks timed out after 20 seconds (1 tasks remaining):
> kernel:   eth1
> kernel: Restarting tasks...<6> Strange, eth1 not stopped
> 
> if i remove the airo module suspend works normally (this is on a
> thinkpad t40).

Thanks for your report.

Let's try to figure out what broke it.

As a first step, please replace drivers/net/wireless/airo.c with the 
version in 2.6.18 and check whether this fixes the issue (you can ignore 
the deprecated warning during compilation).

> --alex--

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

