Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQKWQ3g>; Thu, 23 Nov 2000 11:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129581AbQKWQ30>; Thu, 23 Nov 2000 11:29:26 -0500
Received: from wellspring.nwc.alaska.net ([209.112.130.9]:52673 "EHLO
        alaska.net") by vger.kernel.org with ESMTP id <S129507AbQKWQ3P>;
        Thu, 23 Nov 2000 11:29:15 -0500
Date: Thu, 23 Nov 2000 06:58:53 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: binary garbage in dmesg/boot messages (2.2.18pre23)
Message-ID: <20001123065853.B23839@plato.local.lan>
Mail-Followup-To: Ethan Benson <erbenson@alaska.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20001123054644.A23839@plato.local.lan> <E13yyLo-0007TS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13yyLo-0007TS-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 23, 2000 at 03:31:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 03:31:51PM +0000, Alan Cox wrote:
> > Board Name: Agate.
> > Board Version: AA662195-305.
> 
> So far so good
> 
> > BIOS Vendor: f.=A3^]<94>fA=E8^D.=A3ESC<94>^N^_
> 
> This looks like the table end markers are missing or the length was wrong.
> If you change
> 
> static int __init dmi_table(u32 base, int len, int num, void (*decode)(struct d
> {	 
> 		char *buf;
> 	struct dmi_header *dm;   
> 	u8 *data;
> 	int i=0;
> 
> in arch/i386/kernel/dmi_scan.c to use
> 
> 	int i=1;
> 
> does it then behave nicely ?
> 

yes sure does, thanks!

-- 
Ethan Benson
http://www.alaska.net/~erbenson/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
