Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUIGLsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUIGLsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIGLsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:48:50 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:3592 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S267891AbUIGLsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:48:45 -0400
Date: Tue, 7 Sep 2004 13:50:03 +0200
From: DervishD <disposable1@telefonica.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Weird SCSI subsystem behaviour (ISA related?????)
Message-ID: <20040907115003.GA1412@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I recently upgraded to 2.4.27 and finally remove ISA support
(CONFIG_ISA is now not set). This may be important because the kernel
threads named 'usb-storage-0' and 'scsi_eh_0' are both stuck in a
very high address, namely e086e736 and e086d279. But my ksyms says
this:

[...]
e086b944  scsi_hostlist                     [scsi_mod]
e086b948  scsi_devicelist                   [scsi_mod]
e086b94c  scsi_hosts                        [scsi_mod]
e086b964  scsi_dma_free_sectors             [scsi_mod]
e086b968  scsi_need_isa_buffer              [scsi_mod]

    As far as I can tell, this means that both kernel threads are
stuck somewhere in the code of 'scsi_need_isa_buffer'. Does this mean
that I must set CONFIG_ISA? If the answer is yes: then why
CONFIG_SCSI doesn't depend on CONFIG_ISA? Is all that not related to
ISA in any way (I suppose this is the correct answer) and the problem
is just that both threads are stuck in a wrong address caused by
only-god-knows?

    I use scsi for my card reader, that works without problem
usually. Right now I cannot test if the problem was a loose cable,
bad insertion of the card, etc. but anyway that shouldn't cause
kernel threads to get stuck...

    Thanks in advance :) If anyone wants additional info, just tell.
I'm going to reboot ASAP to see if this problem is persistent or if I
just had bad luck.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
