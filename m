Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVCHKVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVCHKVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVCHKVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:21:04 -0500
Received: from styx.suse.cz ([82.119.242.94]:7128 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261961AbVCHKUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:20:42 -0500
Date: Tue, 8 Mar 2005 11:24:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: dtor_core@ameritech.net, Borislav Petkov <petkov@uni-muenster.de>,
       perex@suse.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] sound/pci/cs4281.c fix typos in the SUPPORT_JOYSTICK=n case
Message-ID: <20050308102402.GE18021@ucw.cz>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <200503070941.59365.petkov@uni-muenster.de> <20050307215206.GH3170@stusta.de> <d120d50005030714126e345fe2@mail.gmail.com> <20050307230633.GJ3170@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307230633.GJ3170@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 12:06:33AM +0100, Adrian Bunk wrote:

> This patch fixes typos in the SUPPORT_JOYSTICK=n case.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks; applied.

> --- linux-2.6.11-mm1-full/sound/pci/cs4281.c.old	2005-03-07 23:45:01.000000000 +0100
> +++ linux-2.6.11-mm1-full/sound/pci/cs4281.c	2005-03-07 23:45:27.000000000 +0100
> @@ -1331,8 +1331,8 @@
>  	}
>  }
>  #else
> -static inline int snd_cs4281_gameport(cs4281_t *chip) { return -ENOSYS; }
> -static inline void snd_cs4281_gameport_free(cs4281_t *chip) { }
> +static inline int snd_cs4281_create_gameport(cs4281_t *chip) { return -ENOSYS; }
> +static inline void snd_cs4281_free_gameport(cs4281_t *chip) { }
>  #endif /* CONFIG_GAMEPORT || (MODULE && CONFIG_GAMEPORT_MODULE) */

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
