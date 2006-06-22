Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWFVOPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWFVOPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWFVOPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:15:21 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:6892 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1751794AbWFVOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:15:20 -0400
Message-ID: <449AA5E9.7000705@draigBrady.com>
Date: Thu, 22 Jun 2006 15:15:05 +0100
From: =?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Dropping Packets in 2.6.17
References: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com> <449A9ADC.9070800@draigBrady.com> <e7e7s2$3qc$1@news.cistron.nl>
In-Reply-To: <e7e7s2$3qc$1@news.cistron.nl>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> In article <449A9ADC.9070800@draigBrady.com>,
> Pádraig Brady  <P@draigBrady.com> wrote:
> 
>>Note there is a max interrupt rate of around 80K/s
>>on x86 at least (not sure about opteron), so make
>>sure you're using NAPI. /proc/interrupts will
>>show your interrupt rate.
> 
> 
> The e1000 driver has some more knobs you can turn. I have this
> in my /etc/modules file:
> 
> e1000 RxAbsIntDelay=256,256 TxAbsIntDelay=256,256 TxDescriptors=1024,1024 RxDescriptors=1024,1024

Yep sorry I should have mentioned those.
I set the descriptors up to the max of 4096
(as the statistical calcs only needed 5ms timestamping accuracy).

I got a large gain also by modifying the e1000 driver to do skb recycling

Pádraig.
