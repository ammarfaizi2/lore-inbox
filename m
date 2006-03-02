Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751992AbWCBQGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWCBQGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWCBQGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:06:31 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:61843 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751988AbWCBQGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:06:30 -0500
Message-ID: <65320.192.54.193.25.1141315183.squirrel@rousalka.dyndns.org>
In-Reply-To: <4406512A.9080708@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	
    <4405F471.8000602@rtr.ca>	
    <1141254762.11543.10.camel@rousalka.dyndns.org>
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
Date: Thu, 2 Mar 2006 16:59:43 +0100 (CET)
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Jens Axboe" <axboe@suse.de>, "Eric D. Mudama" <edmudama@gmail.com>,
       "Tejun Heo" <htejun@gmail.com>,
       "Nicolas Mailhot" <nicolas.mailhot@gmail.com>,
       "Mark Lord" <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Carlos Pardo" <carlos.pardo@siliconimage.com>
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20060118.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le Jeu 2 mars 2006 02:58, Jeff Garzik a écrit :
> Jeff Garzik wrote:
>> For libata, I think an ATA_FLAG_NO_FUA would be appropriate for
>> situations like this...  assume FUA is supported in the controller, and
>> set a flag where it is not.  Most chips will support FUA, either by
>> design or by sheer luck.  The ones that do not support FUA are the
>> controllers that snoop the ATA command opcode, and internally choose the
>> protocol based on that opcode.  For such hardware, unknown opcodes will
>> inevitably cause problems.
>
> This also begs the question... what controller was being used, when the
> single Maxtor device listed in the blacklist was added?  Perhaps it was
> a problem with the controller, not the device.

The controller in the bugzilla entry ie a SiI 3114.
It was a quick fix and I did expect more thorough investigation later
(probably 2.6.17 frame). Though it seems FUA-related problems are so
numerous FUA itself will be blacklisted for 2.6.16, so the limited
blacklist is no longer needed.

The thread leading to the blacklist is referenced in the bugzilla entry

-- 
Nicolas Mailhot

