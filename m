Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTABTXo>; Thu, 2 Jan 2003 14:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbTABTXo>; Thu, 2 Jan 2003 14:23:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16391 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266434AbTABTXn>;
	Thu, 2 Jan 2003 14:23:43 -0500
Date: Thu, 2 Jan 2003 20:32:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "BODA Karoly jr." <woockie@expressz.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.54-sparc64 compile errors
Message-ID: <20030102193209.GB18197@mars.ravnborg.org>
Mail-Followup-To: "BODA Karoly jr." <woockie@expressz.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030102191604.22760J-100000@ligur.expressz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030102191604.22760J-100000@ligur.expressz.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 07:50:59PM +0100, BODA Karoly jr. wrote:
> Hi!
> 
> Some errors and patches, but I'm not sure they are correct:
> 
> o There was no archclean which is needed to make clean

This one is my bad. Deleted accidently when moving archhelp.

Your mailer screwed up all tabs, so patch did not apply.
Also cc: sparclinux@vger.kernel.org next time.

	Sam

> 
> --- arch/sparc64/Makefile       2003-01-02 04:23:15.000000000 +0100
> +++ arch/sparc64/Makefile~      2003-01-02 16:56:48.000000000 +0100
> @@ -74,6 +74,9 @@ drivers-$(CONFIG_OPROFILE)    += arch/sparc
>  tftpboot.img vmlinux.aout:
>         $(Q)$(MAKE) $(build)=arch/sparc64/boot arch/sparc64/boot/$@
> 
> +archclean:
> +       $(Q)$(MAKE) $(clean)=arch/sparc64/boot
> +
>  define archhelp
>    echo  '* vmlinux       - Standard sparc64 kernel'
>    echo  '  vmlinux.aout  - a.out kernel for sparc64'
> 
> 
