Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTILUDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTILUDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:03:00 -0400
Received: from ns.suse.de ([195.135.220.2]:12717 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261827AbTILUCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:02:17 -0400
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
References: <3F621AC4.4070507@cox.net>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I've got an IDEA!!  Why don't I STARE at you so HARD,
 you forget your SOCIAL SECURITY NUMBER!!
Date: Fri, 12 Sep 2003 22:02:15 +0200
In-Reply-To: <3F621AC4.4070507@cox.net> (Kevin P. Fleming's message of "Fri,
 12 Sep 2003 12:13:08 -0700")
Message-ID: <je65jx3hdk.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin P. Fleming" <kpfleming@cox.net> writes:

> --- linux-2.6.0-test5/include/asm-i386/ioctl.h~	Mon Sep  8 12:49:52 2003
> +++ linux-2.6.0-test5/include/asm-i386/ioctl.h	Fri Sep 12 11:58:41 2003
> @@ -53,7 +53,7 @@
>   	 ((size) << _IOC_SIZESHIFT))
>
>   /* provoke compile error for invalid uses of size argument */
> -extern int __invalid_size_argument_for_IOC;
> +extern unsigned int __invalid_size_argument_for_IOC;

Why not make it size_t which is what sizeof actually returns?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
