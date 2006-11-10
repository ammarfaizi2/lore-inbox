Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946756AbWKJQTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946756AbWKJQTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946755AbWKJQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:19:21 -0500
Received: from iona.labri.fr ([147.210.8.143]:16522 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1946752AbWKJQTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:19:20 -0500
Message-ID: <4554A681.2000502@ens-lyon.org>
Date: Fri, 10 Nov 2006 17:19:13 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Monty Montgomery <monty@xiph.org>, Tejun Heo <htejun@gmail.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Douglas Gilbert <dougg@torque.net>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com> <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org> <45533468.1060400@gmail.com> <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com> <20061110161510.GC15031@kernel.dk>
In-Reply-To: <20061110161510.GC15031@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Nov 09 2006, Monty Montgomery wrote:
>   
>> On 11/9/06, Tejun Heo <htejun@gmail.com> wrote:
>>
>>     
>>> drivers/scsi/sg.c interprets SG_DXFER_TO_FROM_DEV as read while
>>> block/scsi_ioctl.c interprets it as write.  I guess this is historic
>>> thing (scsi/sg.c updated but block/scsi_ioctl.c is forgotten).
>>>       
>> Not historic; Jens accidentally implemented it backwards.  No one
>> noticed for a long time.  I submitted a patch for this a few months
>> ago.
>>     
>
> Yeah, I wonder why that did not go in, I remember the full breadth of
> our discussion and you are fully correct. I'll make sure it gets into
> 2.6.19!
>   

Note sure this patch was supposed to fix our freeze, but I just tried on
top of rc5 and it does not seem to fix it.

Brice

