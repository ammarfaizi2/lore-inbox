Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbTDENUc (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTDENUc (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:20:32 -0500
Received: from [213.187.222.25] ([213.187.222.25]:25788 "EHLO
	palpatine.ludvika.nu") by vger.kernel.org with ESMTP
	id S262194AbTDENUa (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 08:20:30 -0500
Subject: RE: Promise TX4 100: neither IDE port enabled
From: Adam Johansson <adam.johansson@madsci.se>
To: Jonathan Vardy <jonathan@explainerdc.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <73300040777B0F44B8CE29C87A0782E101FA98E9@exchange.explainerdc.com>
References: <73300040777B0F44B8CE29C87A0782E101FA98E9@exchange.explainerdc.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049488524.1851.289.camel@dgc.madsci.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1Rubber Turnip 
Date: 05 Apr 2003 15:31:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 17:07, Jonathan Vardy wrote:
> > Without knowing the cause or fix for it I instead run ac-patches.
> > The card(s) are than configured correctly.
> > I now run 2.4.21pre5ac3 and I remember 2.4.21pre4ac4 also worked fine.
> 
> I tried 2.4.21-pre5-ac3 but still I get the same problems, with what
> settings did you compile the kernel?
> 
> I used these:
> 
> On:  PROMISE PDC202{46|62|65|67} support
> On:  Special UDMA Feature
> On:  PROMISE PDC202{68|69|70|71|75|76|77} support
> 
> Off: Special FastTrak Feature
> Off: Support for IDE Raid controllers (EXPERIMENTAL)

I do have Special FastTrak feature turned on as well.
I have also compiled support for IDE Raid + Promise RAID.

dmesg shows the drives at hde and hdg detected as UDMA(100).

ataraid/d0: ataraid/d0p1
Drive 0 is 43979 Mb (33 / 0)
Drive 1 is 43979 Mb (34 / 0)

Still I simply treat it as a Ultra-card and use /dev/hde and /dev/hdg in
a RAID1 config with 2 IBM 45Gb drives.
(though /dev/ataraid/d0p1 exists, something I wasn't aware I had choosen
to compile into the kernel )

"cat /proc/ide/pdc202xx"  says both masters are running UDMA4 and that
the card is an Ultra100.

hdparm -tT /dev/md5 gives;
 Timing buffer-cache reads:	128 Mb in  0.29 seconds =441.38 MB/sec
 Timing buffered disk reads:	64 Mb in  1.77 seconds = 36.16 MB/sec
 
Good luck!
/Adam Johansson

> Yours sincerey, Jonathan Vardy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

