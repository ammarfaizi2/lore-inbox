Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSGWROp>; Tue, 23 Jul 2002 13:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSGWROp>; Tue, 23 Jul 2002 13:14:45 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:11509 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id <S318148AbSGWROp>; Tue, 23 Jul 2002 13:14:45 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Dave Jones'" <davej@suse.de>, "'Christopher Hoover'" <ch@hpl.hp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.24+ fix needed for non-modular video build
Date: Tue, 23 Jul 2002 10:18:27 -0700
Message-ID: <001201c2326c$f5d48e80$7a00000a@derelict>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020723143744.C14323@suse.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 22, 2002 at 01:45:14PM -0700, Christopher Hoover wrote:
> 
>  > -#ifdef MODULE
>  > -#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
>  >  static void videodev_proc_destroy(void)
>  >  {
>  >  	if (video_dev_proc_entry != NULL)
>  > @@ -298,8 +296,6 @@
>  >  	if (video_proc_entry != NULL)
>  >  		remove_proc_entry("video", &proc_root);
>  >  }
>  > -#endif
>  > -#endif
> 
> Why are you removing the inner ifdef too ? This looks like it
> makes sense (to me at least)

It makes sense but it is redundant -- there is a wider-scoped ifdef in
the file that catches that function and others.

-ch

mailto:ch@murgatroid.com
mailto:ch@hpl.hp.com

