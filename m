Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUHSRri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUHSRri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266874AbUHSRri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:47:38 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:6077 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266880AbUHSRpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:45:52 -0400
Message-ID: <4124E701.5020905@rtr.ca>
Date: Thu, 19 Aug 2004 13:44:33 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200408191751.19101.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The READ/WRITE SECTOR commands are not actually used by
any software I know of with HDIO_DRIVE_CMD, so no big deal there.
The ioctl should be limited to SET_FEATURES, IDENTIFY, and SMART.

And you'll get no debate from me on wanting a better interface
moving forward -- I really like the new ATA Command Pass-Through
draft spec (updated today, by the way).

But there'll need to be some overlap between the old and new,
and currently the libata driver has no way for smartmontools
or hdparm to communicate and control drive features like
the cache/readahead settings, and the various SMART capabilities.

Simply dropping HDIO_DRIVE_CMD/HDIO_DRIVE_TASK into there would
immediately gain full compatibility with the existing toolsets,
and give some time for a newer scheme to be rolled out in the
kernel, the tools, and ultimately all of the various distros.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
