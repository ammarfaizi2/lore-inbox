Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTHGQBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTHGQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:00:18 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:39812 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270319AbTHGP5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:57:40 -0400
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to
	2.6.0-test2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: casino_e@terra.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0308071535110.20585-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0308071535110.20585-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060271632.3123.77.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 16:53:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 14:35, Bartlomiej Zolnierkiewicz wrote:
> > Then the bug is that ide_ata66_check is getting called at all in the
> > SATA controller case
> 
> drive->sata ?

drive->sata or hwif->sata. Something like that appears to be needed, or
making ata66_check a HWIF() function so it can be overriden just like
the cable detect half is ?

-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>
