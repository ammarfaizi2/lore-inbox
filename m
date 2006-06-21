Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWFUAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWFUAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWFUAJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:09:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbWFUAIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:08:46 -0400
Date: Tue, 20 Jun 2006 17:12:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
Message-Id: <20060620171204.767547c2.akpm@osdl.org>
In-Reply-To: <44985321.3020609@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944D14.2000308@gmail.com>
	<20060619222223.8f5133a9.akpm@osdl.org>
	<44985321.3020609@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Heres a better version

Well..

***************
*** 312,317 ****
  	}
  
  	pc8736x_init_shadow();
  	return 0;
  }
  
--- 422,428 ----
  	}
  
  	pc8736x_init_shadow();
+ 	pc8736x_sysfs_init(&pdev->dev);
  	return 0;
  }

I don't know how to fix that - pc8736x_gpio_init() doesn't call
pc8736x_init_shadow().

Plus the patch you sent still has spaces all over the place where we should
have tabs.  You can fix that by editing the diff, search for "^+   ".

So I'll drop this patch altogether.  Which is probably for the best at this
stage, because we're expecting a pile of teeny fixes from you agaisnt the
other 19 patches as a result of review comments (yes?)

Once all that has landed we can look at the sysfs-GPIO interface.
