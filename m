Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTIYXVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTIYXVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:21:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:37507 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262029AbTIYXVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:21:50 -0400
Date: Fri, 26 Sep 2003 01:21:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       petero2@telia.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Extend KD?BENT to handle > 256 keycodes.
Message-ID: <20030925232138.GA4720@ucw.cz>
References: <10645086121089@twilight.ucw.cz> <1064508612197@twilight.ucw.cz> <20030925155728.013b6712.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925155728.013b6712.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 03:57:28PM -0700, Andrew Morton wrote:
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> >
> >   input: Create new KD?BENT ioctls with a bigger key range (int), so that
> >          it's posible to recompile kbdutils on 2.6 and load keymaps for
> >          keys beyond 128. kbdutils compiled on 2.4 will keep working on
> >          2.6, unfortunately not vice versa, without changing kbdutils.
> 
> Doesn't compile with older gcc's

Thanks, applied.

> diff -puN drivers/char/vt_ioctl.c~input-06-extend-entries-fix drivers/char/vt_ioctl.c
> --- 25/drivers/char/vt_ioctl.c~input-06-extend-entries-fix	Thu Sep 25 15:55:42 2003
> +++ 25-akpm/drivers/char/vt_ioctl.c	Thu Sep 25 15:55:44 2003
> @@ -77,7 +77,7 @@ asmlinkage long sys_ioperm(unsigned long
>  static inline int
>  do_kdsk_ioctl(int cmd, void *user_kbe, int perm, struct kbd_struct *kbd)
>  {
> -	struct kbentry tmp, *kbe = user_kbe;;
> +	struct kbentry tmp, *kbe = user_kbe;
>  	struct kbentry_old old, *old_kbe = user_kbe;
>  	ushort *key_map, val, ov;
>  
> 
> _
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
