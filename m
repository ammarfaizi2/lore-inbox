Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUI2MP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUI2MP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUI2MP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:15:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:28550 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268330AbUI2MPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:15:03 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roland McGrath <roland@redhat.com>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: notify_parent (was: Re: Linux 2.6.9-rc2)
References: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
	<Pine.LNX.4.61.0409192213250.14392@anakin>
	<jey8j528n2.fsf@sykes.suse.de>
	<Pine.GSO.4.61.0409291403560.18029@waterleaf.sonytel.be>
From: Andreas Schwab <schwab@suse.de>
X-Yow: GOOD-NIGHT, everybody..  Now I have to go administer FIRST-AID
 to my pet LEISURE SUIT!!
Date: Wed, 29 Sep 2004 14:14:07 +0200
In-Reply-To: <Pine.GSO.4.61.0409291403560.18029@waterleaf.sonytel.be> (Geert
 Uytterhoeven's message of "Wed, 29 Sep 2004 14:04:27 +0200 (MEST)")
Message-ID: <jebrfpff1s.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> > -			/* We're back.  Did the debugger cancel the sig?  */
>> > -			if (!(signr = current->exit_code)) {
>> > -			discard_frame:
>> > -			    /* Make sure that a faulted bus cycle isn't
>> > -			       restarted (only needed on the 680[23]0).  */
>> > -			    if (regs->format == 10 || regs->format == 11)
>> > -				regs->stkadj = frame_extra_sizes[regs->format];
>> 
>> This is important if you want continue after a SEGV.
>
> IC. But where should I do that?

Looks like we need a hook in the generic code.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
