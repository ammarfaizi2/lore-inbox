Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUFPSyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUFPSyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFPSyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:54:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25826 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264499AbUFPSxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:53:54 -0400
Message-ID: <40D09733.3070807@pobox.com>
Date: Wed, 16 Jun 2004 14:53:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.7
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <200406161831.40494.dominik.karall@gmx.net>
In-Reply-To: <200406161831.40494.dominik.karall@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
> On Wednesday 16 June 2004 07:56, Linus Torvalds wrote:
> 
>>Ok, it's out there. The most notable change may be the one-liner that
>>should fix the embarrassing FP exception problem. Other than that, we've
>>had a random collection of fixes and updates since rc3. cifs, ntfs,
>>cpufreq. ide, sparc, s390.
>>
>>Full 2.6.6->2.6.7 changelog available at the same places the release is.
>>
>>		Linus
> 
> 
> Is there any reason why the sis900-fix-phy-transceiver-detection.patch wasn't 
> moved to the stable tree? It's a now for a long time in -mm patches and 
> without that patch, a lot of sis900 cards does not work in full-duplex 
> 100Tx-FD mode.

It still needs work, as the updated driver appears to scan the first phy 
incorrectly, which IMO would break _other_ situations that are presently 
working.

I'll try to get to it in the next couple days; the short answer is to 
look at other PCI ethernet drivers and note how they scan MII.

	Jeff


