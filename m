Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265848AbUFDQrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUFDQrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFDQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:47:45 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:53956 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265848AbUFDQrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:47:40 -0400
Message-ID: <40C0A7B4.7020308@myrealbox.com>
Date: Fri, 04 Jun 2004 09:47:48 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.7-rc2] Parport_pc module dependencies changed?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently (can't say exactly when) my printer and parallel Zip drive
stopped working.

Turns out the reason is that the parport_pc module no longer loads
automatically along with the parport and ppa modules.

Here's an excerpt (line-wrapped) from modules.dep:

/lib/modules/2.6.7-rc2/kernel/drivers/scsi/ppa.ko: 
/lib/modules/2.6.7-rc2/kernel/drivers/scsi/scsi_mod.ko /lib/mod
ules/2.6.7-rc2/kernel/drivers/parport/parport.ko

/lib/modules/2.6.7-rc2/kernel/drivers/parport/parport_pc.ko: 
/lib/modules/2.6.7-rc2/kernel/drivers/parport/parport.ko

/lib/modules/2.6.7-rc2/kernel/drivers/parport/parport.ko:
<missing line for parport_pc.ko ??>       <=================

/lib/modules/2.6.7-rc2/kernel/drivers/char/lp.ko: 
/lib/modules/2.6.7-rc2/kernel/drivers/parport/parport.ko


Seems like parport_pc.ko should appear as a dependency for
parport.ko, but doesn't.  (At least on on a PC, anyway.)
