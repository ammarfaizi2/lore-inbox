Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVL2PXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVL2PXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVL2PXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:23:04 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:49338
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750756AbVL2PXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:23:02 -0500
Message-ID: <43B3FF55.4050304@microgate.com>
Date: Thu, 29 Dec 2005 09:23:01 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA burst delay
References: <395333712@web.de>
In-Reply-To: <395333712@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> ... in the (rarely) faulty case, the 2nd burst only starts
 > after another delay of about 600ns, which is too late

Looking at the PCI 2.3 specification,
arbitration latency on the order of a microsecond
or two does not seem excessive for a 33MHz bus.

> ... I deactivated all other pci devices that could disturb the transfers?

Are you accessing registers on your device
during the DMA transfers? If so, the CPU is
acting as a PCI master that could delay granting
the bus to your device.

-- 
Paul Fulghum
Microgate Systems, Ltd.
