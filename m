Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVEaRXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVEaRXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVEaRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:19:35 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:16576 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261994AbVEaRQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:16:36 -0400
Message-ID: <429C9BFA.5090901@robotech.de>
Date: Tue, 31 May 2005 19:16:42 +0200
From: Tobias Reinhard <tracer@robotech.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with concurrent SATA-Writes
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with two SATA-Discs. I have an onboard SIL3114 with
four SATA-Ports an onboard NVIDIA with two SATA-Ports - both controllers
are disable via BIOS (and are not detected by Linux)(only for this test
of course - normally I have other HDD on this ports). The only
controller that is found is the add-on controller in a PCI-Slot
(SIL3112). And that is the one I have trouble with.

If I read or write  (via dd) from the first one -> no problems. Same
when read or write from the second or when I read (only read!) from both
at the same time. Data-Transfer-Rate is around 45MB/s for one HDD.

The problem occures when I try to write on both discs at the same time.
For example I write /dev/zero to the first one and then start to write
/dev/zero to the second one. The System-Load goes up to 4 with nearly
100% io-wait and nearly no write-access to the drives.

Any hints?

- no errormessages in syslog
- happens with Kernel 2.6.11.7 and with 2.6.12-rc5
- HDDs are Samsung Spinpoint 200GB
- (I use the SCSI-SATA-Drivers)

Tobias

