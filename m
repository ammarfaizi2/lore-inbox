Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVDFIUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVDFIUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVDFIT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:19:26 -0400
Received: from mp1-smtp-3.eutelia.it ([62.94.10.163]:14253 "EHLO
	smtp.eutelia.it") by vger.kernel.org with ESMTP id S262033AbVDFIQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:16:01 -0400
Message-ID: <42539ABD.1090103@eutelia.it>
Date: Wed, 06 Apr 2005 10:15:57 +0200
From: Sergio Chiesa <sergio.chiesa@eutelia.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: REPOST [Followup: PROBLEM: Kernel bug at tg3.c:2456]
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

up :-D

-------- Original Message --------
Subject: Followup: PROBLEM: Kernel bug at tg3.c:2456
Date: Thu, 31 Mar 2005 14:34:22 +0200
From: Sergio Chiesa <sergio.chiesa@eutelia.it>
To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0503301842460.13508@scsi.edisontel.it>

Sergio Chiesa wrote:

> 7.7.
> Well, it seems that with the original onboard raid controller the bug
> didn't trigger... the controller was swapped with the lsi logic by my
> supplier because it fails badly with raid-5 arrays (hw/fw related issue)
> I also tried the original broadcom driver version 7.3.5 with similar
> results...

I made some tests again, switching back to the onboard dual aic7902 scsi
controller (non raid) the tg3 dont hung anymore.
I just noticed the IRQ mappings change between the two settings.
The Broadcom eth get always the IRQ #25, the two onboard scsi controllers
get #24 and #25 (shared with the eth, is it harmful??) but the megaraid
driver gets the IRQ #28

I think it is something IRQ related because if the eth hungs but the kernel
is still running I see more than 140000 irq per second with "vmstat".

Hope it helps better!

Sergioc.

