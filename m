Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTIRJRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 05:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTIRJRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 05:17:51 -0400
Received: from smtp.terra.es ([213.4.129.129]:43301 "EHLO tfsmtp3.mail.isp")
	by vger.kernel.org with ESMTP id S262834AbTIRJRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 05:17:50 -0400
From: CASINO_E <CASINO_E@teleline.es>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Reply-To: casino_e@terra.es
Message-ID: <1cbb951cc475.1cc4751cbb95@teleline.es>
Date: Thu, 18 Sep 2003 09:17:47 GMT
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: Changes in siimage driver?
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 of September 2003 14:09, Bartlomiej Zolnierkiewicz wrote:
> controllers. I believe freebsd's workaround is correct and we can
adopt > it.
> For more details please see the other thread regarding siimage.

According to what I've seen in the release notes of the closed-source
siimage driver (I posted what I found), the right fix could be in
netbsd's code, but in sys/dev/ata/wd.c :

         * Some Seagate S-ATA drives have a PHY which can get confused
         * with the way data is packetized by some S-ATA controllers.
         *
         * The work-around is to split in two any write transfer whose
         * sector count % 15 == 1 (assuming 512 byte sectors).
 
I'm not smart enough to try and write a patch, but maybe the siimage
maintainer could have a look to that file...

Eduardo.


