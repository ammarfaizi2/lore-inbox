Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUHSSNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUHSSNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUHSSMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:12:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266631AbUHSSMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:12:39 -0400
Message-ID: <4124ED87.6040702@pobox.com>
Date: Thu, 19 Aug 2004 14:12:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl> <4124E701.5020905@rtr.ca> <4124E9F6.6030000@pobox.com> <4124EB91.60706@rtr.ca>
In-Reply-To: <4124EB91.60706@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  >* I don't mind HDIO_DRIVE_TASK nearly as much as HDIO_DRIVE_CMD,
>  >* since the command protocol is available.
> 
> That's not HDIO_DRIVE_TASKFILE, by the way..  a different beast there.
> 
> HDIO_DRIVE_TASK is just a slightly different form of HDIO_DRIVE_CMD
> for non-data commands (specifically, some SMART commands),
> with a more complete register set being exchanged.

Oops, indeed I meant HDIO_DRIVE_TASKFILE.

Anyway, once the infrastructure for the ATA Pass-thru CDB is implemented 
in libata, it is trivial to implement any of these three HDIO_DRIVE_xxx 
ioctls, using the ioctl data to build a scsi command internally.  A bit 
strange at first glance, but it maximizes the leverage of existing 
kernel infrastructure to send commands, time them out, etc.

	Jeff


