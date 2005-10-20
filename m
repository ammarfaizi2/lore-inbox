Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbVJTDQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbVJTDQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbVJTDQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:16:34 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60392 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751716AbVJTDQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:16:33 -0400
Message-ID: <43570C0E.7060104@rtr.ca>
Date: Wed, 19 Oct 2005 23:16:30 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use a USB  SD/MMC card reader?
References: <20051019193913.GA21749@aitel.hist.no>
In-Reply-To: <20051019193913.GA21749@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> I have an usb card reader (Apacer) in my desktop machine.
..
> Another slot accepts SD/MMC cards.  I tried inserting an MMC card,
> but nothing seems to happen.  Using /dev/sdf doesn't work - no medium.

Rebuild your kernel with "CONFIG_SCSI_MULTI_LUN" enabled
(aka. "Probe all LUNs on each SCSI device" under drivers->scsi).
