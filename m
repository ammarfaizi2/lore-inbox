Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRI1OzI>; Fri, 28 Sep 2001 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276095AbRI1Oyv>; Fri, 28 Sep 2001 10:54:51 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:11279 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276090AbRI1Oxo>;
	Fri, 28 Sep 2001 10:53:44 -0400
Date: Fri, 28 Sep 2001 16:54:06 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Message-ID: <20010928165406.M21524@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BB47F7F.DE2FD301@mail.com> <20010928160250.K21524@come.alcove-fr> <3BB48C29.356901F1@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BB48C29.356901F1@mail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 10:41:45AM -0400, Thomas Hood wrote:

> Stelian Pop wrote:
> > What about making a conditional on 'is_sony_vaio_laptop' here ?
> > (but you need to extends the conditionnal export of this variable
> > from dmi_scan.c / i386_ksyms.c).
> 
> In addition to applying the patch I just sent
> (thood-pnpbiosvaio-patch-20010928-3), you will have
> to move the definition of is_sony_vaio_laptop outside
> the #ifdefs in arch/i386/kernel/dmi_scan.c and i386_ksyms.c

No need for me since I have CONFIG_SONYPI on.

> You or Alan:  For the cleaned up patch, do we export this
> variable unconditionally?

I'd vote for unconditionnally define one int instead of having
something like:
	#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE) || ( defined(CONFIG_PNP) && defined(CONFIG_PROC) )
(and maybe other defines in the future... :( ).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
