Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTIOKaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTIOKaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:30:12 -0400
Received: from main.gmane.org ([80.91.224.249]:52667 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262467AbTIOKaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:30:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Re: SII SATA request size limit
Date: 15 Sep 2003 10:12:47 GMT
Organization: none
Message-ID: <bk43av$cp6$1%proserpine.haus@yggdrasl.demon.co.uk>
References: <200309112357.41592.eu@marcelopenna.org> <1063363288.5330.1.camel@dhcp23.swansea.linux.org.uk> <200309121946.31810.adasi@kernel.pl>
X-Complaints-To: usenet@sea.gmane.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a futile gesture against entropy, Witold Krecicki wrote:

> I've lost some of mails about siimage on LKML, but Im' getting more and more 
> confused about 'hangs' probably caused by siimage driver. I was using 15 
> rqsize, now 128 - doesn't matter. It happens in random moments - sometimes at 
> boot time when drive is fscked, sometimes when I'm trying to copy large 
> amount of data and sometimes without any particular reason after several 
> hours.

Out of interest, do you have some sort of SCSI controller in your
system as well?  I've got a SiI3112 card and I get a hard lock-up pretty
much as soon as anything touches the SCSI bus on my aic7xxx card.
Disabling DMA on the SiI IDE channel seems to work around it, at the
cost of a lot of performance... (this is on stock 2.4.22, BTW)

Setting rqsize to 128 seems perfectly stable for me - my drive reports
itself as a ST380013AS (Seagate Barracuda 7200.7 SATA 80GB).
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("Ja voll, Herr General."                                           )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

