Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWHSSvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWHSSvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWHSSvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 14:51:45 -0400
Received: from id.uw.edu.pl ([193.0.79.161]:38317 "EHLO do.id.uw.edu.pl")
	by vger.kernel.org with ESMTP id S1751770AbWHSSvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 14:51:44 -0400
Date: Sat, 19 Aug 2006 20:52:51 +0200
From: "Marcin 'Rambo' Roguski" <rambo@id.uw.edu.pl>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: mplayer-users@mplayerhq.hu, linux-kernel@vger.kernel.org
Subject: Re: [MPlayer-users] Weird behaviour in ide-scsi driven dvd playback
 with 2.6.17.x
Message-Id: <20060819205251.fd0e8763.rambo@id.uw.edu.pl>
In-Reply-To: <200608192025.58331.vda.linux@googlemail.com>
References: <20060819193408.10a5297a.rambo@id.uw.edu.pl>
	<200608192025.58331.vda.linux@googlemail.com>
Organization: AmiBug
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Aug 19 18:06:33 beethoven kernel: Buffer I/O error on device sr1,
> > logical block 4496

> Sounds like kernel-side problem. ide-scsi says it have problem reding
> data from the media, whereas ide-cd does not have the problem.
> 
> Does this happen while you just copy the file with cp?

It turns out you were right, while I can mount the dvd quite normally:
# mount /dev/dvd -t udf /mnt/dvd
Device /dev/dvd is write-protected, mounting read-only.
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'SOLIDARNOSC', timestamp 2036/02/07 03:58 (1078)

but any attempt to copy the file results in such kernel message.

-- 
perfect guest:
	One who makes his host feel at home.
