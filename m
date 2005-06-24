Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbVFXDLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbVFXDLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVFXDLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:11:02 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:61712 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S263017AbVFXDJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:09:04 -0400
Message-ID: <42BB794B.6080109@rtr.ca>
Date: Thu, 23 Jun 2005 23:08:59 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: SATA speed. Should be 150 or 133?
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
In-Reply-To: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

True SATA drives ignore the "transfer speed",
as it really is meaningless and does not apply.

But most (all?) first-gen SATA drives are really
PATA drives with a SATA bridge built-in.
Some of those drives require that Linux set the
DMA transfer speed for them to work reliably.

Last I looked, the highest valid PATA transfer
speed was still "UDMA/133".  150 just plain
doesn't exist for PATA (and the whole concept
doesn't exist for SATA, so ..)

Cheers
