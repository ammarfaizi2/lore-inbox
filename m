Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVCNAPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVCNAPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVCNAPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:15:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:17343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261597AbVCNAPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:15:07 -0500
Date: Sun, 13 Mar 2005 16:16:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
In-Reply-To: <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>
 <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Mar 2005, Linus Torvalds wrote:
> 
> That said, the "ldt_ss" case should be moved _after_ the conditional
> tests, since most CPU's out there will do static prediction based on
> forward/backwards direction 

Btw, Stas, one thing I'd really like to see is even a partial list of 
anything that actually cares about this. Ie, if there is some known 
Windows app where Wine works better or something like that, just adding 
that information to the comments would be hugely appreciated. 

Another way of saying the same thing: I absolutely hate seeing patches 
that fix some theoretical issue that no Linux apps will ever care about. 
So I'd like to have a bit more of a case for this patch, since I know what 
the case against it is ;)

		Linus
