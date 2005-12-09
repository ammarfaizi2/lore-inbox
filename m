Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVLIBLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVLIBLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 20:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLIBLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 20:11:03 -0500
Received: from relay4.usu.ru ([194.226.235.39]:10640 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750752AbVLIBLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 20:11:01 -0500
Message-ID: <4398D967.4020309@ums.usu.ru>
Date: Fri, 09 Dec 2005 06:09:59 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
References: <20051204232153.258cd554.akpm@osdl.org>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.11; VDF: 6.33.0.15; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/

I just noticed (maybe too late) that this kernel has the "pata_via" 
driver and decided to try it. It works here, but has one drawback: it is 
slower than the old "via82cxxx" IDE driver.

My configuration with the via82cxxx driver:

/dev/hda = disk, QUANTUM FIREBALLlct20
Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1

/dev/hdb = SAMSUNG CD-ROM SC-148F
Drive is old, supports only mdma2

There are also /dev/hdc and /dev/hdd, irrelevant here.

With the via82cxxx driver, I can get speed around 20 MB/s from /dev/hda. 
The pata_via driver downgrades this to 7 MB/s because it needlessly 
drops the disk to MWDMA2 mode.

-- 
Alexander E. Patrakov
