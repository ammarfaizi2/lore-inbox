Return-Path: <linux-kernel-owner+w=401wt.eu-S1754323AbXAAVqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbXAAVqv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXAAVqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:46:51 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:55245 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbXAAVqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:46:50 -0500
Date: Mon, 1 Jan 2007 22:42:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: Andreas Schwab <schwab@suse.de>, Amit Choudhary <amit2030@yahoo.com>,
       Bernd Petrovitsch <bernd@firmix.at>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
In-Reply-To: <200701012241.08240.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.61.0701012242060.24520@yvahk01.tjqt.qr>
References: <88880.94256.qm@web55601.mail.re4.yahoo.com>
 <200701011709.48349.ioe-lkml@rameria.de> <je3b6uhfz4.fsf@sykes.suse.de>
 <200701012241.08240.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 1 2007 22:40, Ingo Oeser wrote:
>On Monday, 1. January 2007 17:25, Andreas Schwab wrote:
>> Ingo Oeser <ioe-lkml@rameria.de> writes:
>> > Then this works, because the side effect (+20) is evaluated only once. 
>> 
>> It's not a side effect, it's a non-lvalue, and you can't take the address
>> of a non-lvalue.
>
>Just verified this. So If we cannot make it work in all cases, it will
>cause more problems then it will solve.
>
>So we are left with a function, which will 
>a) only be used by janitors to provide "kfree(x); x = NULL;" 
>    with an macro KFREE(x) in all the simple cases.

Just checking, where has it been decided that we actually are going to have
kfree_nullify() or whatever the end result happens to be called?


Thanks,
	-`J'
-- 
