Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVJVC3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVJVC3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 22:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVJVC3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 22:29:35 -0400
Received: from zorg.st.net.au ([203.16.233.9]:53434 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932119AbVJVC3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 22:29:34 -0400
Message-ID: <4359A44B.3090804@torque.net>
Date: Sat, 22 Oct 2005 12:30:35 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Luben Tuikov <luben_tuikov@adaptec.com>, Christoph Hellwig <hch@lst.de>,
       Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com> <20051020170330.GA16458@lst.de> <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <20051021180455.GA6834@lst.de> <43592FA1.8000206@adaptec.com> <20051021182009.GA3364@parisc-linux.org>
In-Reply-To: <20051021182009.GA3364@parisc-linux.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Oct 21, 2005 at 02:12:49PM -0400, Luben Tuikov wrote:
> 
>>>That beeing said I tried this approach.  It looks pretty cool when you
>>>think about it, but the block layer is quite a bit too heavyweight for
>>>queueing up a few SMP requests, and we need to carry too much useless
>>>code around for it.
>>
>>That's the last reason not to implement SMP as a block device.
>>But this is good that you tried it and it "flopped".  This way
>>people will stop repeating "SMP... block device".
> 
> 
> Block layer != Block device.
> 
> Nobody wants to implement SMP as a block device.
> 
> The question is whether the SMP interface should be implemented as part
> of the block layer.

However, the block layer is used in the context of a
block device (and in some cases a char device).
If SAS domain discovery is done from the user space, and
the root file system is the far side of a SAS expander,
there are no suitable devices, just the SAS initiator
(HBA) which currently we cannot address via the block layer.


Doug Gilbert

