Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSF3Tui>; Sun, 30 Jun 2002 15:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSF3Tuh>; Sun, 30 Jun 2002 15:50:37 -0400
Received: from p033.as-l031.contactel.cz ([212.65.234.225]:8320 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S315213AbSF3Tug>;
	Sun, 30 Jun 2002 15:50:36 -0400
Date: Sun, 30 Jun 2002 21:49:20 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Martin Dalecki <dalecki@evision-ventures.com>, alex@ssi.bg,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: HDIO_GETGEO accessibility (was Re: [PATCH] 2.5.24 IDE 95 (fwd))
Message-ID: <20020630194920.GC3778@ppc.vc.cvut.cz>
References: <Pine.SOL.4.30.0206301848370.26714-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0206301848370.26714-200000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2002 at 06:52:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> I hope you dont mind Petr.

No problem.
 
But I have one, unrelated... Today I found that VMware does not run
on 2.5.24 with rawdisks for non-root users because of ioctl(hdd, HDIO_GETGEO, ...)
is guarded by "if (!capable(CAP_SYS_ADMIN)) return -EACCES;". And so it
fails although user has read-write access to /dev/hdX.

Is this change really intentional? It is GET, not SET operation, and user has
access to /dev/hdX. If this change is intentional, I'll recommend VMware
to gain priviledges around disk geometry accesses, but I do not think that
user should need SYS_ADMIN for retrieving disk geometry.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
