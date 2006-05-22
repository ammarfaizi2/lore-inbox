Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWEVHWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWEVHWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWEVHWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:22:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21384 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932580AbWEVHWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:22:06 -0400
Message-ID: <4471669C.4040403@garzik.org>
Date: Mon, 22 May 2006 03:22:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com>
In-Reply-To: <446AC418.4070704@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> * Proposed solution
> 
> It seems that the only solution is to make use of the PCS presence bits 
> somehow.  It is know that 6300ESB family of controllers have flaky 
> presence bits (ata_piix marks them with PIIX_FLAG_IGNORE_PCS), but I 
> couldn't find any document/errata for PCS bits for any other 
> controllers.  So, we can use PCS for all !PIIX_FLAG_IGNORE_PCS 
> controllers or take a conservative approach and make use of it only on 
> cases where ghosting problem is reported (ICH7 and 8, I guess.  Can 
> anyone test 6?).
> 
> Please note that we already use some use of the PCS value when probing 
> SATA port.  If its value is zero, we skip the port.  It's done this way 
> mainly due to historical reasons - until recently ata_piix didn't have 
> MAP tables to map PM/PS/SM/SS to specific ports thus used the PCS values 
> in rougher form.
> 
> Jeff, what do you think?


Sounds sane...

	Jeff


