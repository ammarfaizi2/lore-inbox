Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUL1LYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUL1LYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 06:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbUL1LYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 06:24:08 -0500
Received: from mercure.inha.fr ([194.214.199.252]:21698 "EHLO mercure.inha.fr")
	by vger.kernel.org with ESMTP id S261198AbUL1LYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 06:24:03 -0500
Message-ID: <41D14251.4030704@inha.fr>
Date: Tue, 28 Dec 2004 12:24:01 +0100
From: Gildas LE NADAN <gildas.le-nadan@inha.fr>
Organization: Institut National d'Histoire de l'Art (INHA)
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unkillable processes using samba, xfs and lvm2 snapshots (k 2.6.10)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experience hangs on samba processes on a filer using xfs over lvm2 as 
data partitions, when there is active snapshots of the xfs partitions.

I have a clone of the production server (same software, same hardware) 
where the situation can be reproduced perfectly.

Testings showed that the result was the same, whether the snapshots were 
mounted or not : smbd processes are locked and unkillable while the 
machine is normaly working otherwise, except software reboot is 
impossible and hardware reset is needed.

I noticed Brad Fitzpatrick's case in kernel 2.6.10 changelog 
(http://lkml.org/lkml/2004/11/14/98) and tested kernel 2.6.10 today 
without success.

Configuration is the following :
- supermicro m/b with dual Xeon 2,8Ghz (SMT is active)
- 1 GB ram,
- adaptec u320 raid controler
- kernel 2.6.10
- debian sarge
- samba 3
- LVM2
- XFS with quota turned on

All software are from debian sarge packages, except the kernel.

I'm not able to determine if the problem is more xfs, device mapper or 
samba related, and was not able to do extensive testings (using a 
different filesystem, testing with a different daemon, etc...), but 
SMT/SMP testings showed that this is not a SMP/SMT related problem.

I've compiled the kernel with the debugging options, so I might provide 
additional informations if needed as in Brad's case.

Sincerely,
Gildas LE NADAN
(Please CC me as I didn't suscribe to LKML)
