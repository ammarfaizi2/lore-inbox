Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSFNXvr>; Fri, 14 Jun 2002 19:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFNXvq>; Fri, 14 Jun 2002 19:51:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27799 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314702AbSFNXvq>;
	Fri, 14 Jun 2002 19:51:46 -0400
Subject: Re: [Patch] tsc-disable_A5
From: john stultz <johnstul@us.ibm.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Dave Jones <davej@suse.de>, marcelo@conectiva.com.br,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0206141827510.31514-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Jun 2002 16:44:30 -0700
Message-Id: <1024098271.4358.8.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-14 at 16:29, Kai Germaschewski wrote:
> I suppose you could it rewrite like
> 
> ...
> CONFIG_X86_WANT_TSC=y (or whatever)
> ...
> 
> if [ some_condition ]; then
>   define_bool CONFIG_X86_TSC n
> else
>   define_bool CONFIG_X86_TSC $CONFIG_X86_WANT_TSC
> fi
> 
> Not exactly elegant, but it should work ;)

Yep, my first release was done in a similar fashion, but Alan suggested
the patch take on its current form. There may be cases where we want to
know if we have a TSC even if we don't want to use them. 

Thread link:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.3/1188.html

Thanks for the suggestion,
-john

