Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274013AbRIXQmQ>; Mon, 24 Sep 2001 12:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRIXQl7>; Mon, 24 Sep 2001 12:41:59 -0400
Received: from codepoet.org ([166.70.14.212]:30017 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S274016AbRIXQl2>;
	Mon, 24 Sep 2001 12:41:28 -0400
Date: Mon, 24 Sep 2001 10:41:53 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: toon@vdpas.hobby.nl, linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed
Message-ID: <20010924104153.A29097@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, toon@vdpas.hobby.nl,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010924124131.A4755@vdpas.hobby.nl> <E15lUoP-0002Js-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15lUoP-0002Js-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 24, 2001 at 01:26:13PM +0100, Alan Cox wrote:
> > It didn't get trough the boot-sequence (RedHat-7.1).
> > After some investigation it turned out that it hang in
> > the kudzu script, and further on also in the netfs script.
> > The programs `/usr/sbin/updfstab', `/usr/sbin/kudzu' and
> > the command `mount -a' are all falling into a loop.
> 
> The scsi partition handling code in 2.4.10 is broken
> 
> The cause seems to be the new gendisk changes, although quite why is still
> a mystery.

I didn't have time to dig into it, since I needed to get some work
done.  So I reverted drivers/scsi/sd.c to stock 2.4.9, which made
the problem go away for me,

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
