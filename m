Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSGCM2M>; Wed, 3 Jul 2002 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSGCM2M>; Wed, 3 Jul 2002 08:28:12 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:42765 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S316965AbSGCM2K>; Wed, 3 Jul 2002 08:28:10 -0400
Message-ID: <3D22EEB0.B3266763@compro.net>
Date: Wed, 03 Jul 2002 08:31:44 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephane Charette <scharette@packeteer.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: performance impact of using noapic
References: <20020702192006Z316884-686+254@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Charette wrote:

> 
> My questions are:
> 
> 1) am I right in thinking that "noapic" will force all interrupts to be handled by 1 CPU?

Yes.

> 
> 2) how would you force all interrupts from only 1 hardware device (and not all devices) to be handled by 1 processor, as hinted in the paragraph quoted above?

echo "00000001" > /proc/irq/19/smp_affinity

Will cause irq 19 to be serviced by processor 1

echo "00000003" > /proc/irq/19/smp_affinity

Will allow irq 19 to be serviced by processor 1 and 2

You could also do this in the driver if you wanted.

Note that this will not work when noapic is used..


Mark
