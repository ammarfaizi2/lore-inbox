Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272248AbTHNJSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272249AbTHNJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:18:41 -0400
Received: from dyn-ctb-203-221-74-134.webone.com.au ([203.221.74.134]:41737
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S272248AbTHNJSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:18:40 -0400
Message-ID: <3F3B53CC.8030209@cyberone.com.au>
Date: Thu, 14 Aug 2003 19:18:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide: limit drive capacity to 137GB if host doesn't	support
 LBA48
References: <200308140324.45524.bzolnier@elka.pw.edu.pl> <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>On Iau, 2003-08-14 at 02:24, Bartlomiej Zolnierkiewicz wrote:
>
>> 	hwif->rqsize			= old_hwif.rqsize;
>>-	hwif->addressing		= old_hwif.addressing;
>>+	hwif->no_lba48			= old_hwif.no_lba48;
>>
>
>This change is a bad idea. Its called "addressing" because that is what
>it is about (see SATA and ATA specs). In future SATA addressing becomes
>a 0,1,2 value because 48bits isnt enough, it may get more forms beyond
>that.
>

Wow! Isn't that over 100 thousand TB? ;)


