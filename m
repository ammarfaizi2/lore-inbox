Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270437AbTGaRYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274832AbTGaRYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:24:07 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:52878 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270437AbTGaRYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:24:03 -0400
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to
	2.6.0-test2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307311632.56813.eu@marcelopenna.org>
References: <Pine.SOL.4.30.0307311710440.8394-100000@mion.elka.pw.edu.pl>
	 <200307311632.56813.eu@marcelopenna.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059671993.17454.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Jul 2003 18:19:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-31 at 20:32, Marcelo Penna Guerra wrote:
> I mean it doesn't crash the system during intensive read/write operations. It 
> has something to do with limiting the max bk per request to 7.5 (hwif-
> >rqsize=15).

Already handled in 2.4.22pre-ac

> 	if(is_sata(hwif))
> 	{
> +		drive->id->hw_config |= 0x6000;
> 		if(strstr(drive->id->model, "Maxtor"))
> 			return 3;
> 		return 4;
>  	}

We never check the cable bits for SATA so this is a no-op


