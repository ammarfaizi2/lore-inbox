Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSEAMde>; Wed, 1 May 2002 08:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSEAMdd>; Wed, 1 May 2002 08:33:33 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:24107 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S311320AbSEAMdc>; Wed, 1 May 2002 08:33:32 -0400
Message-Id: <200205011233.AA00060@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Wed, 01 May 2002 21:33:20 +0900
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 compile error ( e100, Alternate Intel driver )
In-Reply-To: <20020501134305.I29327@suse.de>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I change drivers/net/e100/e100_phy.c at line 876 from void __devexit to void,
then I change kernel configuration from eepro100 to e100, compile, and boot up fine.

=====

>On Wed, May 01, 2002 at 08:23:11PM +0900, Seiichi Nakashima wrote:
>
> > === compile error EtherExpressPro/100 support ( e100, Altrenate Intel driver ) ===
> > 
> > io_apic.c:221: warning: `move' defined but not used
> > drivers/net/net.o: In function `e100_diag_config_loopback':
> > drivers/net/net.o(.text+0x52ff): undefined reference to `e100_phy_reset'
> > make: *** [vmlinux] Error 1
>
>Remove the __devexit tag from e100_phy_reset()'s definition in
>drivers/net/e100/e100_phy.c around line 873
>
>I already sent Jeff a patch for this.
>
>-- 
>| Dave Jones.        http://www.codemonkey.org.uk
>| SuSE Labs
>
>

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
