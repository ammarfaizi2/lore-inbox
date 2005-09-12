Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVILSJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVILSJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVILSJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:09:39 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:52238 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S932115AbVILSJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:09:38 -0400
Subject: Re: 2.6.13 brings buffer underruns when burning DVDs at high
	speeds (16x)
From: Mathieu Fluhr <mfluhr@nero.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1126527113.2169.6.camel@localhost.localdomain>
References: <1126527113.2169.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Nero AG
Date: Mon, 12 Sep 2005 20:07:56 +0200
Message-Id: <1126548476.1991.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hummm Okay. After making some ugly changes (I basically reverted all
the /drivers/block subdir to version 2.6.12.6), I still have buffer
underruns.

Does anyone know where it could come from ? I would say that I am a
little bit stuck now. I am quite sure that it is also not comming from
the devices driver (ide-cd, usb-storage...) as I tried with different
devices on different ports (mostly IDE and emulated SCSI via USB) with
the same result.

Note: This is also happening with k3b ;-)

On Mon, 2005-09-12 at 14:11 +0200, Mathieu Fluhr wrote:
> Hello all,
> 
> It seems that something has been broken when passing from 2.6.12 to
> 2.6.13 regarding the SCSI burning engine. When burning a DVD at 16x
> (with ide-cd SEND_PACKET command, or with the SG interface, no matter
> the driver used), you get tons of buffer underruns. This was not
> appearing in 2.6.12.
> 
> I would suspect something in the block devices driver, but I am not
> really sure... and I did not have enough time yet to look deeply in the
> source code ;-)
> 
> Best Regards,
> Mathieu
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

