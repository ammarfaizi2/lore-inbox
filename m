Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318015AbSGWMeg>; Tue, 23 Jul 2002 08:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSGWMeg>; Tue, 23 Jul 2002 08:34:36 -0400
Received: from ns.suse.de ([213.95.15.193]:19473 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318015AbSGWMef>;
	Tue, 23 Jul 2002 08:34:35 -0400
Date: Tue, 23 Jul 2002 14:37:44 +0200
From: Dave Jones <davej@suse.de>
To: Christopher Hoover <ch@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, ch@murgatroid.com
Subject: Re: [PATCH] 2.5.24+ fix needed for non-modular video build
Message-ID: <20020723143744.C14323@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Christopher Hoover <ch@hpl.hp.com>, linux-kernel@vger.kernel.org,
	ch@murgatroid.com
References: <20020722134514.B11556@friction.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020722134514.B11556@friction.hpl.hp.com>; from ch@hpl.hp.com on Mon, Jul 22, 2002 at 01:45:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:45:14PM -0700, Christopher Hoover wrote:

 > -#ifdef MODULE
 > -#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 >  static void videodev_proc_destroy(void)
 >  {
 >  	if (video_dev_proc_entry != NULL)
 > @@ -298,8 +296,6 @@
 >  	if (video_proc_entry != NULL)
 >  		remove_proc_entry("video", &proc_root);
 >  }
 > -#endif
 > -#endif

Why are you removing the inner ifdef too ? This looks like it
makes sense (to me at least)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
