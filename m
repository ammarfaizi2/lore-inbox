Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276059AbRI1ODf>; Fri, 28 Sep 2001 10:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276063AbRI1ODQ>; Fri, 28 Sep 2001 10:03:16 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:31249 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276059AbRI1OC6>;
	Fri, 28 Sep 2001 10:02:58 -0400
Date: Fri, 28 Sep 2001 16:02:52 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Message-ID: <20010928160250.K21524@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BB47F7F.DE2FD301@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BB47F7F.DE2FD301@mail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 09:47:43AM -0400, Thomas Hood wrote:

[ Some detailed PnP BIOS driver explication snipped]
> I attach a revised patch which cuts out proc support.  Hopefully
> this will allow your kernel to boot.  This is just a hack; I'll
> submit a proper fix to Alan later.

I confirm that the revised patch makes a bootable kernel for me.

> Stelian: Your report made me go back and look at something Alan
> told me earlier about Vaio laptops.  At the time I didn't fully 
> understand what he meant when he said:
> > If you query the current device status on a Vaio and some other boxes
> > using the 32bit API your computer dies horribly shortly afterwards.
> I didn't realize that he meant the "current" configuration as
> opposed to the "boot" configuration.  Stupid of me.
[...]
> -	pnp_proc_init();
> +	// pnp_proc_init();

What about making a conditional on 'is_sony_vaio_laptop' here ?
(but you need to extends the conditionnal export of this variable 
from dmi_scan.c / i386_ksyms.c).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
