Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTGBHUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTGBHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 03:20:17 -0400
Received: from ns.mock.com ([209.157.146.194]:13513 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id S261365AbTGBHUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 03:20:14 -0400
Message-Id: <5.1.0.14.2.20030702002400.060d8658@mail.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 02 Jul 2003 00:34:35 -0700
To: Jeff Garzik <jgarzik@pobox.com>
From: Jeff Mock <jeff-ml@mock.com>
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F01DA62.9080707@pobox.com>
References: <5.1.0.14.2.20030701114153.060dd098@mail.mock.com>
 <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
 <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
 <5.1.0.14.2.20030701114153.060dd098@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-DCC-meer-Metrics: wobble.mock.com 1035; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:00 PM 7/1/2003 -0400, Jeff Garzik wrote:
>Jeff Mock wrote:
>>With this new change does the BIOS (on an Intel 875P / ICH5
>>motherboard) still need the drives to be set to legacy mode, or can
>>it be set to enhanced mode to access the full complement of SATA
>>and PATA devices?
>
>Yep, you can enable enhanced (also called native) mode for SATA, to get 
>the full spread of 6 devices normally possible (4 pata + 2 sata).
>
>         Jeff

Wow, that's great, it works really well.  I'm doing a software raid-0
across the two sata drives, I've been stressing it all afternoon with
no problems.

To see the CONFIG_SCSI_ATA_* options during configuration I had to set
CONFIG_SCSI=y  (I had it set to CONFIG_SCSI=m previously.)  Also, if
you want to boot from the SATA drives you should also set
CONFIG_BLK_DEV_SD=y, or maybe load the module from initrd.

I enjoy having the drives called /dev/sd[ab], it makes me feel like I
paid more money for them.

jeff

