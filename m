Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbRHFG6e>; Mon, 6 Aug 2001 02:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbRHFG6Y>; Mon, 6 Aug 2001 02:58:24 -0400
Received: from lutra.sztaki.hu ([193.225.86.1]:15039 "EHLO lutra.sztaki.hu")
	by vger.kernel.org with ESMTP id <S267018AbRHFG6K>;
	Mon, 6 Aug 2001 02:58:10 -0400
Date: Mon, 06 Aug 2001 08:58:16 +0200 (MET DST)
From: Gergely Madarasz <gorgo@sztaki.hu>
Subject: Re: 2.4.8-pre4 drivers/net/wan/comx.c unresolved symbol
In-Reply-To: <1101.997078634@ocs3.ocs-net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.GS4.4.33.0108060857040.5076-100000@lutra.sztaki.hu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Keith Owens wrote:

> This is probably already known but 2.4.8-pre4 drivers/net/wan/comx.c
> has an unresolved symbol proc_get_inode when compiled as a module.
>
> I was pleasently suprised when doing a full kernel compile as modules.
> 840 modules created, only one unresolved symbol.

It is using a symbol which was exported in 2.2, but is not exported in
2.4. Either the driver needs a major rewrite to work as a module (it works
compiled into the kernel) or proc_get_inode needs to be exported again.

-- 
Madarasz Gergely          gorgo@sztaki.hu          gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
                  HuLUG: http://mlf.linux.rulez.org/

