Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbTDNQqT (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTDNQqT (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:46:19 -0400
Received: from routeree.utt.ro ([193.226.8.102]:57798 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S263548AbTDNQqS (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:46:18 -0400
Message-ID: <48500.194.138.39.56.1050339678.squirrel@webmail.etc.utt.ro>
Date: Mon, 14 Apr 2003 20:01:18 +0300 (EEST)
Subject: Re: Bug: slab corruption in 2.5.67-mm1
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <akpm@digeo.com>
In-Reply-To: <20030412181805.1b90bee8.akpm@digeo.com>
References: <3E988DA2.4080600@tmsusa.com>
        <20030412181805.1b90bee8.akpm@digeo.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton said:
> J Sloan <joe@tmsusa.com> wrote:
>>
>> This may be of interest -
>>
>> kernel: 2.5.67-mm1
>>
>> Linux distro: Red Hat 8.0 + updates
>>
>> Hardware:
>> Celeron 1.2 Ghz on Intel Motherboard
>> 512 MB RAM, 2x e100 ethernet
>
> whoa.  Uniprocessor.
>
>> ---- snip ----
>> Freeing unused kernel memory: 312k freed
>> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
>> Adding 514072k swap on /dev/hda2.  Priority:42 extents:1
>> kjournald starting.  Commit interval 5 seconds
>> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
>> EXT3-fs: mounted filesystem with ordered data mode.
>> Slab corruption: start=dfa2f320, expend=dfa2f97f, problemat=dfa2f328
>> Data: ********6A
>
> Yes, this means that someone ran put_task_struct() against an
> already-freed task_struct.  There's some deubg code in -mm which is
> supposed to trap this, but it obviously didn't trigger for some reason.
>
> Until someone finds a way to reproduce this we're a bit stuck.  A code
> audit may find it.

FYI
Same thing happend on my machine *once*, in the same place
(i.e mounting root fs -- JFS) but i forgot the full report on my home
machine :-(.
Kernel 2.5.67 mm1 compiled by gcc 3.2.2 and booted with "debug"
on kernel command line. Couldn't reproduce it :-(
Machine: Duron 700 MHz, 256 M RAM, chipset Via KT133, ATI Radeon VE QY
graphics card, CS4239 sound card, no ethernet.

Distribution Slackware 8.1 + updates.

Calin
-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


