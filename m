Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWCTI4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWCTI4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWCTI4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:56:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47036 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932251AbWCTI4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:56:23 -0500
Date: Sun, 19 Mar 2006 19:47:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: -mm: PM=y, VT=n doesn't compile
Message-ID: <20060319184754.GD3550@elf.ucw.cz>
References: <20060317171814.GO3914@stusta.de> <20060318114825.75dba55a.akpm@osdl.org> <200603182058.58389.rjw@sisk.pl> <200603182128.02955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603182128.02955.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK, here they go.

ACK.

> Index: linux-2.6.16-rc6-mm2/include/linux/vt_kern.h
> ===================================================================
> --- linux-2.6.16-rc6-mm2.orig/include/linux/vt_kern.h
> +++ linux-2.6.16-rc6-mm2/include/linux/vt_kern.h
> @@ -73,6 +73,11 @@ int con_copy_unimap(struct vc_data *dst_
>  int vt_waitactive(int vt);
>  void change_console(struct vc_data *new_vc);
>  void reset_vc(struct vc_data *vc);
> +#ifdef CONFIG_VT
> +int is_console_suspend_safe(void);

I guess I'd just do static inline ... and put code here, but both
versions are okay.

> +#else
> +static inline int is_console_suspend_safe(void) { return 1; }
> +#endif
>  
>  /*
>   * vc_screen.c shares this temporary buffer with the console write code so that

-- 
42:             i < SampleTable.Length;
