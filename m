Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271166AbTGPWbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271157AbTGPWbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:31:08 -0400
Received: from ausadmmsrr502.aus.amer.dell.com ([143.166.83.89]:24845 "HELO
	AUSADMMSRR502.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S271170AbTGPW3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:29:07 -0400
X-Server-Uuid: 586817ae-3c88-41be-85af-53e6e1fe1fc5
Message-ID: <1058395431.1481.6.camel@localhost.localdomain>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Date: Wed, 16 Jul 2003 17:43:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 130B0AA512045268-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We had this discussion before, back when I first submitted the large
> block device patches.  The consensus then was to use EFI, or LDM.

GNU parted has had the GPT code for a couple years now, and
CONFIG_EFI_PARTITION has been in both 2.4.x and 2.5.x trees for over a
year.  To the best of my knowledge and experience, it works equally well
on x86 as on IA-64, modulo booting with traditional BIOSs of course.

# parted /dev/sdb print
# parted /dev/sdb mklabel gpt
# parted /dev/sdb mkpartfs p ext2 0.017 some-really-big-number

partx in util-linux can even tell the kernel about it without requiring
a reboot.

I'd definitely be interested to know of cases where it doesn't work, so
I can get them addressed.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

