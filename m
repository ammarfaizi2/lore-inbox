Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbRB1PRW>; Wed, 28 Feb 2001 10:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbRB1PRK>; Wed, 28 Feb 2001 10:17:10 -0500
Received: from 2-031.cwb-adsl.telepar.net.br ([200.193.161.31]:32242 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130214AbRB1PQ5>; Wed, 28 Feb 2001 10:16:57 -0500
Date: Wed, 28 Feb 2001 10:37:56 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: peg@bitmap.phx.mcd.mot.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.2-ac6
Message-ID: <20010228103756.G24856@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	peg@bitmap.phx.mcd.mot.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010228061317.A28217@bitmap.phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010228061317.A28217@bitmap.phx.mcd.mot.com>; from peg@bitmap.phx.mcd.mot.com on Wed, Feb 28, 2001 at 06:13:18AM -0700
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 28, 2001 at 06:13:18AM -0700, peg@bitmap.phx.mcd.mot.com escreveu:
> I just pulled down the ac6 patch to 2.4.2 kernel and after applying it without
> problems I did a make menuconfig with the following result:
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> scripts/Menuconfig: MCmenu0: command not found

I think this patch from Keith cures this


Index: 2.9/arch/i386/config.in
--- 2.9/arch/i386/config.in Wed, 28 Feb 2001 12:44:01 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.1.2 644)
+++ 2.9(w)/arch/i386/config.in Wed, 28 Feb 2001 12:46:03 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.1.2 644)
@@ -379,6 +379,6 @@ bool '  Memory mapped I/O debugging' CON
 bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
-endmenu
-
 fi
+
+endmenu

