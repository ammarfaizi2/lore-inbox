Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283561AbRLRBjM>; Mon, 17 Dec 2001 20:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRLRBjC>; Mon, 17 Dec 2001 20:39:02 -0500
Received: from ns.suse.de ([213.95.15.193]:36623 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283561AbRLRBit>;
	Mon, 17 Dec 2001 20:38:49 -0500
Date: Tue, 18 Dec 2001 02:38:48 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Erik Andersen <andersen@codepoet.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <20011217182724.A17312@codepoet.org>
Message-ID: <Pine.LNX.4.33.0112180237440.23388-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Erik Andersen wrote:


> This fix from -pre6 broke NCR5380 so that it does not compile
> when linked into the kernel (i.e.  not as a module).  This patch
> fixes it.  Please apply for 2.4.17-rc2,

This doesn't look right..

> -static int __init do_NCR53C400_setup(char *str)
> -static int __init do_NCR53C400A_setup(char *str)
> -static int __init do_DTC3181E_setup(char *str)

You nuked the functions..

>  __setup("ncr5380=", do_NCR5380_setup);
>  __setup("ncr53c400=", do_NCR53C400_setup);
>  __setup("ncr53c400a=", do_NCR53C400A_setup);
>  __setup("dtc3181e=", do_DTC3181E_setup);

But not the references to them. What error are you seeing ?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

