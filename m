Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWEOVlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWEOVlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWEOVlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:41:21 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:3804 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S964898AbWEOVlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:41:20 -0400
Message-ID: <4468F58E.8050903@keyaccess.nl>
Date: Mon, 15 May 2006 23:41:34 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SMP alternatives: skip with UP kernels.
References: <4461341B.7050602@keyaccess.nl> <4461B24A.7050805@suse.de> <4461D16A.3000301@keyaccess.nl> <44632A62.2020505@suse.de> <4463A78F.5030703@keyaccess.nl> <44647454.3050800@suse.de>
In-Reply-To: <44647454.3050800@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann wrote:

>> Yes, the #ifdef in arch/i386/kernel/module.c is a bit clumsy.
> 
> Yep, thats why.  I wanted avoid exactly that.  Having some code need to
> know that function foobar() is only available with CONFIG_BAZ is set is
> really ugly ...
> 
> The attached patch hides the magic in alternative.h and provides some
> dummy inline functions for the UP case (gcc should manage to optimize
> away these calls).  No changes in module.c.

Works for me; it doesn't easily get non-clumsy in module.c I see. Sure 
you want to keep smp_alt_once outside the #ifdef? Seems to not be doing 
anything other than being set to 1 for !SMP.

Thanks,
Rene.
