Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTK3PwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 10:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTK3PwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 10:52:04 -0500
Received: from mail.gmx.de ([213.165.64.20]:9606 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264922AbTK3PwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 10:52:02 -0500
X-Authenticated: #4512188
Message-ID: <3FCA1220.2040508@gmx.de>
Date: Sun, 30 Nov 2003 16:52:00 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       marcush@onlinehome.de
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <20031129165648.GB14704@gtf.org> <3FC94F5A.8020900@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311301547.32347.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
 > Okay, stop bashing IDE driver... three mails is enough...
 >
 > Apply this patch and you should get similar performance from IDE driver.
 > You are probably seeing big improvements with libata driver because 
you are
 > using Samsung and IBM/Hitachi drives only, for Seagate it probably 
sucks just
 > like IDE driver...
 >
 > IDE driver limits requests to 15kB for all SATA drives...
 > libata driver limits requests to 15kB only for Seagata SATA drives...

If you read my message closely then you should have understand that 
setting the request highr *didn't* help, ie

echo "max_kb_per_request:128" > /proc/ide/hde/settings

made *no* difference, so I won't even try that patch. As far I have 
understood this is exactly the thing you changed in the patch. If I am 
mistaken, then I take it back.

Prakash

