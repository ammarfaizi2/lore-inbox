Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUFSRxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUFSRxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 13:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUFSRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 13:53:44 -0400
Received: from wasp.conceptual.net.au ([203.190.192.17]:37076 "EHLO
	wasp.net.au") by vger.kernel.org with ESMTP id S264371AbUFSRxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 13:53:42 -0400
Message-ID: <40D47DA2.1000201@wasp.net.au>
Date: Sat, 19 Jun 2004 21:53:38 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Hart <darren@dvhart.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IR Remotes under 2.6
References: <1087658340.2792.31.camel@farah>
In-Reply-To: <1087658340.2792.31.camel@farah>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:
> I had some thoughts regarding the >=2.6.6 approach to handling remotes
> as keyboards (specifically the ir-kbd-i2c driver).
> 
> 1) First, I believe the kernel can really only recognize the receiver,

> Thoughts?

Something completely different.. Perhaps userspace?

I'm using a streamzap USB ir remote with lirc. I have a modified version of Nils Faebers kbdd 
package that does the translation and injects the packets into /dev/misc/uinput.
Whammo. Userspace IR remote to keyboard translator.

You may want to do it in kernel space however. I'm just throwing it out there.
Modified version here http://www.wasp.net.au/~brad/kbdd-lirc-0.01.tar.gz
Ugly and bad code is most probably mine :p)

If you have a good reason to keep it in kernel space, them my argument is null and void :p)
It's nice being able to specify Remote->Key maps on a per app basis depending on what you are 
running at the time.

Makes controlling bash scripts using dialog really easy by remote :p)

Regards,
Brad
