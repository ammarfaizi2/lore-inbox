Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293094AbSCACxJ>; Thu, 28 Feb 2002 21:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293366AbSCACv0>; Thu, 28 Feb 2002 21:51:26 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26105
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310309AbSCACqX>; Thu, 28 Feb 2002 21:46:23 -0500
Date: Thu, 28 Feb 2002 18:47:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluesmoke/MCE support optional
Message-ID: <20020301024710.GF2711@matchmail.com>
Mail-Followup-To: Paul Gortmaker <p_gortmaker@yahoo.com>,
	marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C7E465A.4B3F4D9@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7E465A.4B3F4D9@yahoo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 10:01:46AM -0500, Paul Gortmaker wrote:
> 
> Meant to do this a while ago.  Could do it via adding "nosmoke.c"  :-)
> (similar to fs/noquot.c) instead of #ifdef in bluesmoke.c, if somebody
> had a strong preference one way or the other.
> 
> Patch is against 2.4.18, complete with Aunt Tillie(tm) help text, etc.
> 
> Paul.
> 
> 
> --- Documentation/Configure.help~	Sat Feb  2 06:50:31 2002
> +++ Documentation/Configure.help	Thu Feb 28 09:01:28 2002
> @@ -17450,6 +17450,17 @@
>    The module is called shwdt.o. If you want to compile it as a module,
>    say M here and read Documentation/modules.txt.
>  	      
> +Machine Check Exception
> +CONFIG_X86_MCE
> +  Machine Check Exception support allows the processor to notify the
> +  kernel if it detects a problem (e.g. overheating, component failure).
> +  The action the kernel takes depends on the severity of the problem, 
> +  ranging from a warning message on the console, to halting the machine.
> +  Your processor must be a Pentium or newer to support this - check the 
> +  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
> +  have a design flaw which leads to false MCE events - for these and
> +  old non-MCE processors (386, 486), say N.  Otherwise say Y.
> +

This should be tied to the processor type options...
