Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWGRSJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWGRSJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWGRSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:09:06 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:5318 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S932335AbWGRSJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:09:05 -0400
Message-ID: <44BD2370.8090506@ru.mvista.com>
Date: Tue, 18 Jul 2006 22:07:44 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: libata pata_pdc2027x success on sparc64
References: <200607172358.k6HNwYhF002052@harpo.it.uu.se>
In-Reply-To: <200607172358.k6HNwYhF002052@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Mikael Pettersson wrote:

> In contrast, the old IDE pdc202xx_new driver had lots
> of problems with CRC errors causing it to disable DMA.

    Hm, from my experience it usually falls back to UltraDMA/44 and then the 
thing startrt working...

> I wasn't able to manually tune it above udma3 without
> getting more errors. This isn't sparc64-specific: I've
> had similar negative experience with the old IDE Promise
> drivers in a PowerMac.

    This happens because the "old" driver misses the PLL calibration code.
    You may want to try these Albert's patches:

http://marc.theaimsgroup.com/?t=110992452800002&r=1&w=2
http://marc.theaimsgroup.com/?t=110992471500002&r=1&w=2
http://marc.theaimsgroup.com/?t=110992490100002&r=1&w=2
http://marc.theaimsgroup.com/?t=111019238400003&r=1&w=2

    It looks like they were never considered for accepting into the kernel
while they succesfully solve this issue. Maybe Albert could try pushing them 
into -mm tree once more?

WBR, Sergei

