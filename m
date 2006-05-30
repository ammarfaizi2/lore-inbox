Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWE3B3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWE3B3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWE3B3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:29:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751549AbWE3B3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:17 -0400
Date: Mon, 29 May 2006 18:33:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [patch 03/61] lock validator: sound/oss/emu10k1/midi.c cleanup
Message-Id: <20060529183317.0101f28d.akpm@osdl.org>
In-Reply-To: <20060529212319.GC3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212319.GC3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:23:19 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> move the __attribute outside of the DEFINE_SPINLOCK() section.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  sound/oss/emu10k1/midi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/sound/oss/emu10k1/midi.c
> ===================================================================
> --- linux.orig/sound/oss/emu10k1/midi.c
> +++ linux/sound/oss/emu10k1/midi.c
> @@ -45,7 +45,7 @@
>  #include "../sound_config.h"
>  #endif
>  
> -static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
> +static __attribute((unused)) DEFINE_SPINLOCK(midi_spinlock);
>  
>  static void init_midi_hdr(struct midi_hdr *midihdr)
>  {

I'll tag this as for-mainline-via-alsa.
