Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTK3Q2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbTK3Q2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:28:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264935AbTK3Q2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:28:15 -0500
Message-ID: <3FCA1A8F.3000103@pobox.com>
Date: Sun, 30 Nov 2003 11:27:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org, marcush@onlinehome.de
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <20031129165648.GB14704@gtf.org> <3FC94F5A.8020900@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311301547.32347.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Apply this patch and you should get similar performance from IDE driver.
> You are probably seeing big improvements with libata driver because you are
> using Samsung and IBM/Hitachi drives only, for Seagate it probably sucks just
> like IDE driver...

Looks good to me.


> IDE driver limits requests to 15kB for all SATA drives...
> libata driver limits requests to 15kB only for Seagata SATA drives...
> 
> Both drivers still need proper fix for Seagate drives...

Yep.  Do you have the Maxtor fix, as well?  It's in libata's SII driver, 
though it should be noted that the Maxtor errata only occurs for 
PATA<->SATA bridges, and not for real Maxtor SATA drives.

	Jeff



