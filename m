Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbUDFUL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDFUL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:11:27 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:31717 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263986AbUDFULZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:11:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16499.3204.604627.205193@gargle.gargle.HOWL>
Date: Tue, 6 Apr 2004 16:01:08 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "John Stoffel" <stoffel@lucent.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.6.5-rc3: cat /proc/ide/hpt366 kills disk on second channel
In-Reply-To: <200404061900.36497.bzolnier@elka.pw.edu.pl>
References: <16496.41345.341470.807320@gargle.gargle.HOWL>
	<16498.54669.886834.727923@gargle.gargle.HOWL>
	<200404061900.36497.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

You're patch does the trick, I can now do cat /proc/ide/hpt366 without
any problems.  Time to re-sync my md mirror.

I'll also pull this patch forward to 2.6.5 and make sure to submit it
to Linus/Andrew, unless you'll do that part?

I do wish the cable detection stuff worked though... too bad about the
outb() stuff.  Maybe I can poke at it and figure out what kind of
locking is required here to make this work right.  Would it need to be
queued up as a regular HWIF command?  Can you tell I don't know what
I'm talking about?  *grin*

Thanks again,
John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
