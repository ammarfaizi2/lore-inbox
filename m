Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSGHWsO>; Mon, 8 Jul 2002 18:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSGHWsN>; Mon, 8 Jul 2002 18:48:13 -0400
Received: from hell.ascs.muni.cz ([147.251.60.186]:58754 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S317221AbSGHWsM>; Mon, 8 Jul 2002 18:48:12 -0400
Date: Tue, 9 Jul 2002 00:50:25 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.11+?
Message-ID: <20020709005025.B1745@mail.muni.cz>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1026167822.16937.5.camel@UberGeek>; from austin@digitalroadkill.net on Mon, Jul 08, 2002 at 05:37:02PM -0500
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echalon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mosad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I know a few people that reports it works well for them. How ever for me
and some other do not. System is redhat 7.2, ASUS A7V MB, /dev/hda is on promise
controller. Following helps a lot:

while true; do sync; sleep 3; done

How did you modify the params of bdflush? I do not want to suspend i/o buffers 
nor disk cache.. 

Another thing to notice, the X server has almost every time some pages swaped to
the swap space on /dev/hda. When bdflushd is flushing buffers X server stops as
has no access to the swap area during i/o lock.

On Mon, Jul 08, 2002 at 05:37:02PM -0500, Austin Gonyou wrote:
> I do things like this regularly, and have been using kernels 2.4.10+ on
> many types of boxen, but have yet to see this behavior. I've done this
> same type of test with 16k blocks up to 10M, and not had this problem I
> usually do test with regard to I/O on SCSI, but have tested on IDE,
> since we use many IDE systems for developers. I found though, that using
> something like LVM, and overwhelming it, causes bdflush to go crazy. I
> can hit the wall you refer to then.When bdflushd is too busy...it does
> in fact seem to *lock* the system, but of course..it's just bdflush
> doing it's thing. If I modify the bdflush params..this causes things to
> work just fine, at least, useable.

-- 
Luká¹ Hejtmánek
