Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUBBRD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUBBRD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:03:57 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:30199 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265710AbUBBRDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:03:55 -0500
Subject: Re: [PATCH] SElinux compile fix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Morris <jmorris@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0402021710460.19699@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0402021710460.19699@waterleaf.sonytel.be>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1075741402.3579.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 02 Feb 2004 12:03:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 11:11, Geert Uytterhoeven wrote:
> Spinlock code needs <linux/sched.h>
> 
> --- linux-2.6.2-rc3/security/selinux/ss/services.c	2004-01-01 20:23:54.000000000 +0100
> +++ linux-m68k-2.6.2-rc3/security/selinux/ss/services.c	2004-01-09 22:16:22.000000000 +0100
> @@ -16,6 +16,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
>  #include <linux/in.h>
> +#include <linux/sched.h>
>  #include <asm/semaphore.h>
>  #include "flask.h"
>  #include "avc.h"
> --- linux-2.6.2-rc3/security/selinux/ss/sidtab.c	2004-01-01 20:23:54.000000000 +0100
> +++ linux-m68k-2.6.2-rc3/security/selinux/ss/sidtab.c	2004-01-09 22:13:55.000000000 +0100
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
> +#include <linux/sched.h>
>  #include "flask.h"
>  #include "security.h"
>  #include "sidtab.h"

Thanks for the fix.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

