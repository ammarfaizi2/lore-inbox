Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276829AbRJKUBk>; Thu, 11 Oct 2001 16:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276802AbRJKUBW>; Thu, 11 Oct 2001 16:01:22 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:24583 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S276855AbRJKUAm>; Thu, 11 Oct 2001 16:00:42 -0400
Message-Id: <200110112001.f9BK0vY99173@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unconditional include of <linux/module.h> in aic7xxx driver 
In-Reply-To: Your message of "Thu, 11 Oct 2001 20:52:38 BST."
             <E15rlsk-0004Vf-00@the-village.bc.nu> 
Date: Thu, 11 Oct 2001 14:00:57 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> unconditional in the aic7xxx driver?  Assuming MODULE_LICENSE is
>> properly qualified by an #ifdef MODULE, the driver appears to compile
>> and function correctly without this include.  Are MODULE attributes
>> (MODULE_VERSION/AUTHOR/DESCRIPTION/etc.) now supposed to be included in
>> static configurations?
>
>It's always been meant to work always included. For non modules it defines
>the right do nothing handlers to avoid you having to get ifdefs into the
>kernel code

So, in theory I could nuke many of the remaining "#ifdef MODULE"'s?
This wasn't done in the aic7xxx driver for 2.4.12.  My only concern with
doing this is having the driver still work on older kernel versions.

--
Justin
