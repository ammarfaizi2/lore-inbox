Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbSKMNPX>; Wed, 13 Nov 2002 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbSKMNPX>; Wed, 13 Nov 2002 08:15:23 -0500
Received: from [203.117.131.12] ([203.117.131.12]:11496 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S267196AbSKMNPW>; Wed, 13 Nov 2002 08:15:22 -0500
Message-ID: <3DD251FF.6000007@metaparadigm.com>
Date: Wed, 13 Nov 2002 21:22:07 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Brian Jackson <brian-kernel-list@mdrx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
References: <20021113002529.7413.qmail@escalade.vistahp.com>            <3DD1A899.8080800@mvista.com>            <3DD1C046.3010603@metaparadigm.com> <20021113031518.8700.qmail@escalade.vistahp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically my last setup was ext3 + LVM1 + qla2x00 (6.0.1b3).
This is exactly what is in 2.4.19pre10aa4. With general fileserver
load using netatalk on one machine, openldap on another machine
and oracle on another. One of them would oops every 5-8 days.

I haven't come up with a repeatable test yet to generate the oops.

I intend on trying fsx + bonnie in parallel on a test setup with same
kernels to see if I can reproduce the oops. Then i'll see if I can
reproduce with qla2300 6.01 driver. If still not okay, i'll try dm
and evms. Basically I want a stable ext3 + volume manager + qla2x00

~mc

On 11/13/02 11:15, Brian Jackson wrote:
> 
> I am testing OpenGFS on this hardware(it is on loan from OSDL), I could 
> probably do some testing for you if you have some specifics you want to 
> try. I am having trouble with the volume management portion of OpenGFS 
> also(but I don't necessarily think they are related).
> --Brian Jackson
> 
> <snip>
> 
>>
>> I'm interested in finding what magic is required to get a stable
>> setup with qlogic drivers and LVM. I have tested many kernel 
>> combinations,
>> vendor kernels, stock, -aa and variety of different qlogic drivers
>> inclusing the one with the alleged stack hog fixes and they all ooops
>> when using LVM (can take up to 10 days of production load). Removing
>> LVM 45 days ago and now I have 45 days uptime on these boxes.
>> I'm currently building a test setup to try and excercise this problem
>> as all my other boxes with qlogic cards are production and can't be
>> played with. I really miss having volume management and a SAN setup
>> is really where you need it the most.
>> ~mc

