Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWEFKhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWEFKhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 06:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWEFKhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 06:37:14 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:29125 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWEFKhN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 06:37:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WS4gmdZM/SzLJdg5A7bq/5T/ccnVqymVH0YSMKZbR2zyv8iAKvrL9gpP+naBm/Y7vRMlWSIVcvhHPXSqAr6o+goWIqZgaMaaL0uSJrL3M7X3j+x5lHDjHm1kJVH9fhKO4lVt2XOL5pGqR3Xm0R2VKozfa0yGzU/nXH2gf0Qqh/U=
Message-ID: <8bf247760605060337q7c6a3bay94f1ff86d482ffb1@mail.gmail.com>
Date: Sat, 6 May 2006 03:37:12 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sd-io CTO error - advice
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I am using OMAP.

  I am  trying to extend sd card driver in linux to support sdio.

  When i send CMD 5 - i get CTO error . i dont know whats the problem?.

   if i do enable MMC_DEBUG prints i do get the response sometimes.

   I dont know why the response is not consitent. add some printks it
works sometimes. remove them it does not work.

   I tried sending CMD 5 in a loop - most of the time i do get CTO Errors?.


Any ideas on how to solve this problem?


is it related to the clock - i think it is set to what ever 400KHZ
(this works for MMC/SD Cards)
Is it different for SDIO ?.

The specs says 0-400KHZ during init phase.


Any ideas, where i should look at.

I have set CTO Value to the maximus - 0xff.




MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
MMC1: set_ios: clock 400000Hz busmode 1 powermode 1 Vdd 0.21
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0001 (CMD 5): EOC
MMC1: Response 90ff8000
MMC1: End request, err 0
MMC: req done (05): 0: 90ff8000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0001 (CMD 5): EOC
MMC1: Response 90000000
MMC1: End request, err 0
MMC: req done (05): 0: 90000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
        MMC IRQ 0080 (CMD 5): CTO
MMC1: Command timeout, CMD5
MMC1: Response 00000000
MMC1: End request, err 1
MMC: req done (05): 1: 00000000 00000000 00000000 00000000
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
