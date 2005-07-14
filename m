Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbVGNNvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVGNNvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVGNNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:51:54 -0400
Received: from host.atlantavirtual.com ([209.239.35.47]:711 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S263019AbVGNNvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:51:17 -0400
Subject: Re: fdisk: What do plus signs after "Blocks" mean?
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Konstantin Kudin <konstantin_kudin@yahoo.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, lkml@dervishd.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507131222300.14635@yvahk01.tjqt.qr>
References: <20050712204822.84567.qmail@web52001.mail.yahoo.com>
	 <Pine.LNX.4.61.0507131222300.14635@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1121349002.3718.11.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 14 Jul 2005 09:50:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I always thought;

First 446 bytes are boot code and all
Next 64 bytes are for 4 partition records, 16 bytes each
Last 2 bytes are signature 

?

-fd


On Wed, 2005-07-13 at 06:24, Jan Engelhardt wrote:
> > Guys, thanks a lot for the explanations!
> >
> > Actually, it seems like one can backup information on ALL partitions
> >by using the command "sfdisk -dx /dev/hdX". Supposedly, it reads not
> >only primary but also extended partitions. "sfdisk -x /dev/hdX" should
> >be then able to write whatever is known back to the disk.
> 
> MBR size is 448 bytes, the rest is "the partition table", with space for four 
> entries. If one wants more, then s/he creates a [primary] partition, tagging 
> it "extended", and the "extended partiton table" is within that primary 
> partition. So yes, by dd'ing /dev/hdX, you get everything. Including "lost 
> sectors" if you dd it back to a bigger HD.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

