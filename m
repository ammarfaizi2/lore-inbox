Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUBYUrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUBYUrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:47:04 -0500
Received: from mail.ccur.com ([208.248.32.212]:44561 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261522AbUBYUqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:46:52 -0500
Date: Wed, 25 Feb 2004 15:17:28 -0500
From: Joe Korty <joe.korty@ccur.com>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040225201728.GA12900@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <0E3FA95632D6D047BA649F95DAB60E5703EF97F9@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703EF97F9@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 11:46:00AM -0500, Moore, Eric Dean wrote:
> I don't see the banner displayed by the driver
> which would contain the FwRev, Ports, MaxQ, IRQ.
> I suspect hw/fw issues with the card itself.
> 
> What happens when you attach drives to the card;
> e.g. does the driver load then?
> 
> Can you upgrade your firmware to the latest.
> http://www.lsilogic.com/downloads/selectDownload.do


Hi Eric,
Problem solved.

The Fusion chip is soldered onto the motherboard.  I went into
the BIOS and discovered a little selection called (paraphrased)
'Execute LSI firmware' which was disabled.  When I enabled it,
all the boottime Fusion errors and warning went away.

This is a dual Opteron system branded 'Celsius' and made by
Fujitsu/Siemens.

It would be great if the driver could detect this and print
a 'is the LSI Fusion firmware enabled?' message in the log.

Regards, and thank you for looking into this,
Joe
