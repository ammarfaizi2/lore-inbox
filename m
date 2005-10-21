Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVJUSM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVJUSM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVJUSM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:12:56 -0400
Received: from magic.adaptec.com ([216.52.22.17]:53890 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965057AbVJUSMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:12:55 -0400
Message-ID: <43592FA1.8000206@adaptec.com>
Date: Fri, 21 Oct 2005 14:12:49 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com> <20051020170330.GA16458@lst.de> <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <20051021180455.GA6834@lst.de>
In-Reply-To: <20051021180455.GA6834@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 18:12:53.0596 (UTC) FILETIME=[0E13F1C0:01C5D66B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 14:04, Christoph Hellwig wrote:
>>How about this: Why not as a char device?
> 
> you can implement a char device using the block layer.  See
> drivers/scsi/{ch.c,osst.c,sg.c,st.c} for examples.

Christoph, you failed to see that my question was _rhetorical_.

> That beeing said I tried this approach.  It looks pretty cool when you
> think about it, but the block layer is quite a bit too heavyweight for
> queueing up a few SMP requests, and we need to carry too much useless
> code around for it.

That's the last reason not to implement SMP as a block device.
But this is good that you tried it and it "flopped".  This way
people will stop repeating "SMP... block device".

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
