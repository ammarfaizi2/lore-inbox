Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSE0XDf>; Mon, 27 May 2002 19:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSE0XDe>; Mon, 27 May 2002 19:03:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2547 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314468AbSE0XDe>; Mon, 27 May 2002 19:03:34 -0400
Subject: Re: Use of CONFIG_M686
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020527222928.GI1848@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 01:05:46 +0100
Message-Id: <1022544346.4123.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 23:29, J.A. Magallon wrote:
> 
> On 2002.05.28 J.A. Magallon wrote:
> >Hi all...
> >
> >arch/i386/kernel/traps.c:
> >
> >#ifndef CONFIG_M686 <=================== which also passes if PII, P4...
> >void __init trap_init_f00f_bug(void)
> >...
> 
> Would it be enough with
> 
> #if defined(CONFIG_M586) || defined(CONFIG_M586TSC) || defined(CONFIG_M586MMX)
> 
> 386-486 do not have the bug, do ?

You misunderstand the intent. A 386 or 486 kernel will run on a Pentium
and could therefore hit the error. A PPro kernel would die earlier
anyway. Of course its long been PPRO|Athlon|... and the ifdef wanted
updating. I'd ifdef it on CONFIG_X86_FOOF_BUG and put the FOOF thing
into arch/i386/Config.in nicely with the other stuff

