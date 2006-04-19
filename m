Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWDSJ4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWDSJ4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWDSJ4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:56:48 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:65396 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750872AbWDSJ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:56:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=kqyX5edToRpKRZfHtdFk7QV429AIc4gjjCquqs/0eB1ReksMjuksT1K6YKqe2kzoFTHx3Xnui9ba5Z0x6NI/WuwNG+hN+hcI5pcJqlZuGXQmSuAtj+jxNPiBhqjU7dbgkbuJ8nAyBQoe9Vt6lKuKjELfnqx2HPhs/jJZIt5cTWw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [RFC: 2.6 patch] fix the INIT_ENV_ARG_LIMIT dependencies
Date: Wed, 19 Apr 2006 11:59:40 +0200
User-Agent: KMail/1.8.3
Cc: Adrian Bunk <bunk@stusta.de>, jdike@karaya.com,
       linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
References: <20060415143036.GI15022@stusta.de>
In-Reply-To: <20060415143036.GI15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191159.41148.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 April 2006 16:30, Adrian Bunk wrote:
> This patch fixes the INIT_ENV_ARG_LIMIT dependencies to what seems to
> have been intended.

Yes, the global rename USERMODE -> UML in Kconfig missed something, it seems. 
My bad.

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> Spotted by Jean-Luc Leger.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

> --- linux-2.6.17-rc1-mm2-full/init/Kconfig.old	2006-04-15
> 16:26:46.000000000 +0200 +++
> linux-2.6.17-rc1-mm2-full/init/Kconfig	2006-04-15 16:27:12.000000000 +0200
> @@ -46,8 +46,8 @@
>
>  config INIT_ENV_ARG_LIMIT
>  	int
> -	default 32 if !USERMODE
> -	default 128 if USERMODE
> +	default 32 if !UML
> +	default 128 if UML
>  	help
>  	  Maximum of each of the number of arguments and environment
>  	  variables passed to init from the kernel command line.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live
> webcast and join the prime developer group breaking into this new coding
> territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
http://it.messenger.yahoo.com
