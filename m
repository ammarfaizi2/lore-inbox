Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWA3LlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWA3LlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWA3LlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:41:02 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23735 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932225AbWA3LlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:41:00 -0500
Date: Mon, 30 Jan 2006 11:51:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 4/5] vt: Update spawnpid to use a task_ref.
Message-ID: <20060130105143.GA2953@elf.ucw.cz>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com> <m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com> <m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 29-01-06 00:33:27, Eric W. Biederman wrote:
> 
> This is a classic example of a random kernel subsystem
> holding a pid for purposes of signalling it later.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> 
> 
> ---
> 
>  drivers/char/keyboard.c |    8 ++++----
>  drivers/char/vt_ioctl.c |    5 +++--
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> 7ed8301463a49ad03f8c9de2bbf8c41a5d9843ea
> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> index 8b603b2..4e1f2e0 100644
> --- a/drivers/char/keyboard.c
> +++ b/drivers/char/keyboard.c
> @@ -109,7 +109,8 @@ struct kbd_struct kbd_table[MAX_NR_CONSO
>  static struct kbd_struct *kbd = kbd_table;
>  static struct kbd_struct kbd0;
>  
> -int spawnpid, spawnsig;
> +TASK_REF(spawnpid);

Could we get some nicer syntax of declaration? This does not look like
declaration, and looks ugly to my eyes.
								Pavel
-- 
Thanks, Sharp!
