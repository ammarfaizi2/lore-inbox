Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTIBRBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbTIBQ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:58:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:7647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264055AbTIBQy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:54:29 -0400
Date: Tue, 2 Sep 2003 10:00:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp broken
In-Reply-To: <3F509D82.5050409@kolumbus.fi>
Message-ID: <Pine.LNX.4.44.0309021000000.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.6.0-test4 software suspend seems to be badly broken...looking at it 
> (relevant code included below), no wonder. pm_suspend_disk() calls 
> swsusp_save(), which is is essentially a nop. The intention was clearly 
> that after resume control would return from swsusp_save(), which isn't 
> the case, instead we return from swsusp_write(), and power down again!!!

Could you please try -test4-mm4? This problem should be fixed in there.

Thanks,


	Pat


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> 2.6.0-test4 software suspend seems to be badly broken...looking at it 
> (relevant code included below), no wonder. pm_suspend_disk() calls 
> swsusp_save(), which is is essentially a nop. The intention was clearly 
> that after resume control would return from swsusp_save(), which isn't 
> the case, instead we return from swsusp_write(), and power down again!!!

Could you please try -test4-mm4? This problem should be fixed in there.

Thanks,


	Pat


