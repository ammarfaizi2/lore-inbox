Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTIUHzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 03:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTIUHzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 03:55:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39950
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262354AbTIUHzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 03:55:52 -0400
Date: Sun, 21 Sep 2003 00:36:43 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: casino_e@terra.es
cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Changes in siimage driver?
In-Reply-To: <1cbb951cc475.1cc4751cbb95@teleline.es>
Message-ID: <Pine.LNX.4.10.10309210035440.9002-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did that already, yet the linux does not like odd break point in the SG
list and thus there are some ugliess to solve.

Andre Hedrick
LAD Storage Consulting Group

On Thu, 18 Sep 2003, CASINO_E wrote:

> On Wednesday 17 of September 2003 14:09, Bartlomiej Zolnierkiewicz wrote:
> > controllers. I believe freebsd's workaround is correct and we can
> adopt > it.
> > For more details please see the other thread regarding siimage.
> 
> According to what I've seen in the release notes of the closed-source
> siimage driver (I posted what I found), the right fix could be in
> netbsd's code, but in sys/dev/ata/wd.c :
> 
>          * Some Seagate S-ATA drives have a PHY which can get confused
>          * with the way data is packetized by some S-ATA controllers.
>          *
>          * The work-around is to split in two any write transfer whose
>          * sector count % 15 == 1 (assuming 512 byte sectors).
>  
> I'm not smart enough to try and write a patch, but maybe the siimage
> maintainer could have a look to that file...
> 
> Eduardo.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

