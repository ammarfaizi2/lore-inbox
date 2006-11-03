Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWKCVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWKCVwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWKCVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:52:35 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:44435 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932182AbWKCVwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:52:34 -0500
Date: Fri, 3 Nov 2006 22:51:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611031945220.30722@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.61.0611032250550.23669@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <454AA4C5.3070106@googlemail.com> <Pine.LNX.4.61.0611030911540.13091@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0611031248030.17174@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0611031257400.17174@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.61.0611031349490.9606@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0611031945220.30722@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > > So anyway, why do you need _llseek? Can't you just use lseek()
>> > > > like
>> > > > everyone else?
>> > > 
>> > > Because I want it to work with glibc 2.0 that I still use on one
>> > > machine.
>> > 
>> > BTW. is it some interaction with symbols defined elsewhere or were
>> > _syscall
>> > macros dropped altogether? Which glibc symbol should I use in #ifdef
>> > to tell if
>> > glibc has 64-bit support?
>> 
>> -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64
>> 
>> I think the second is not needed.
>
> I see, but the question is how do I test in C preprocessor that glibc is
> sufficiently new to react on them?

__GLIBC_MAJOR__ and __GLIBC_MINOR__


	-`J'
-- 
