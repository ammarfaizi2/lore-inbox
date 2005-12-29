Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVL2QDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVL2QDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVL2QDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:03:22 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:17089 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1750786AbVL2QDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:03:22 -0500
Date: Thu, 29 Dec 2005 17:03:12 +0100
Message-Id: <395603262@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: PaulFulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA burst delay
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Paul Fulghum <paulkf@microgate.com> schrieb am 29.12.05 16:30:20:
>
>Burkhard Schölpen wrote:
>> ... in the (rarely) faulty case, the 2nd burst only starts
>> after another delay of about 600ns, which is too late
>
>Looking at the PCI 2.3 specification,
>arbitration latency on the order of a microsecond
>or two does not seem excessive for a 33MHz bus.

Okay, then I think I have to figure out, why I cannot get longer bursts than 512 Bits...does anybody have a clue how I can handle that?

>> ... I deactivated all other pci devices that could disturb the transfers?
>
>Are you accessing registers on your device
>during the DMA transfers? If so, the CPU is
>acting as a PCI master that could delay granting
>the bus to your device.

No, I just made sure that not. There are no register accesses during dma transfer. The driver sends the application to sleep until an interrupt signals the completeness. 

Kind regards,
Burkhard

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

