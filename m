Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRKOVvt>; Thu, 15 Nov 2001 16:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281094AbRKOVvj>; Thu, 15 Nov 2001 16:51:39 -0500
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:58872 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S281075AbRKOVvY>; Thu, 15 Nov 2001 16:51:24 -0500
Date: Thu, 15 Nov 2001 23:51:21 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat description for proc.txt
Message-ID: <20011115235121.B4624@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com> <20011115115939.I5739@lynx.no> <15348.8974.587924.655924@abasin.nj.nec.com> <20011115133734.P5739@lynx.no> <15348.10494.577151.173831@abasin.nj.nec.com> <je7ksriwah.fsf@sykes.suse.de> <15348.12126.264831.627333@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15348.12126.264831.627333@abasin.nj.nec.com>
User-Agent: Mutt/1.3.23i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 04:10:54PM -0500, Sven Heinicke wrote:
> +"ctxt" the contest switches.

The number of _context_ switches since boot, IIUC.

> +"processes" is the number of processes that have run since boot.  This
> +includes forks, don't know if it includes threads.

It counts the number of successful fork(), vfork() and clone() system
calls (and other in-kernel calls of do_fork(), which are, e.g. used to
create idle tasks for all CPUs on SMP systems).  So, yes, it does
include (kernel level) threads.

(The above is obtained from several greps on 2.4.12 source tree)

Marius Gedminas
-- 
main(k){float i,j,r,x,y=-16;while(puts(""),y++<15)for(x
=0;x++<84;putchar(" .:-;!/>)|&IH%*#"[k&15]))for(i=k=r=0;
j=r*r-i*i-2+x/25,i=2*r*i+y/10,j*j+i*i<11&&k++<111;r=j);}
/* Mandelbrot in ASCII. */
