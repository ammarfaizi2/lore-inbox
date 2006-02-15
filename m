Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422979AbWBOFxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbWBOFxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422981AbWBOFxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:53:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422979AbWBOFxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:53:20 -0500
Date: Tue, 14 Feb 2006 21:52:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] Add missing return value of kauditd_thread
Message-Id: <20060214215216.5abac525.akpm@osdl.org>
In-Reply-To: <s5h4q31btlb.wl%tiwai@suse.de>
References: <s5h4q31btlb.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> Add the missing return value of kauditd_thread().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 0a813d2..a08fc96 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -300,6 +300,7 @@ static int kauditd_thread(void *dummy)
>  			remove_wait_queue(&kauditd_wait, &wait);
>  		}
>  	}
> +	return 0;
>  }
>  
>  void audit_send_reply(int pid, int seq, int type, int done, int multi,

Patch is already present in the seemingly-moribund audit git repo.
