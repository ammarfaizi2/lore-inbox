Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUACOAb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUACOAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 09:00:30 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:9910 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S263244AbUACOAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 09:00:25 -0500
Subject: Re: IDE-RAID Drive Performance
From: Andre Tomt <lkml@tomt.net>
To: Nuno Alexandre <na@imaginere.dk>
Cc: linux-kernel@vger.kernel.org, Nicklas Bondesson <nicke@nicke.nu>
In-Reply-To: <20031230122119.1566247a@Genbox>
References: <S265736AbTL3KoB/20031230104401Z+18387@vger.kernel.org>
	 <20031230122119.1566247a@Genbox>
Content-Type: text/plain
Message-Id: <1073138426.8863.33.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 03 Jan 2004 15:00:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 12:21, Nuno Alexandre wrote:
> /dev/hda:
>  Timing buffer-cache reads:   1320 MB in  2.00 seconds = 659.44 MB/sec
>  Timing buffered disk reads:  140 MB in  3.02 seconds =  46.40 MB/sec
> 
> Using:
> -d1 -u1 -m16 -c3 -W1 -A1 -k1 -X70 -a 8192

Wow, slow down for a minute. Most IDE chipset drivers does a excellent
job at autotuning the max *safe settings* for your drive/chipset
combination. Mucking around with hdparm parameters blindfolded will only
cause you grief in form of data loss and system instability sooner than
later.

Usually when one gets into performance problems with IDE in Linux, the
chipset specific driver is not enabled, making the system fallback to
the generic driver - OR the drive and controller combination is
considered unsafe with faster settings.

Without any user intervention at all, my Seagate 7200 120G's does 55MB/s
in the infamious hdparm test, on a VIA KT266 based board, both in
2.6.1-rc1 and 2.4.23.


