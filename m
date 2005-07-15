Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVGONgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVGONgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVGONgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:36:44 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:33765 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S261364AbVGONgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:36:00 -0400
Date: Fri, 15 Jul 2005 15:34:31 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub2.ifh.de
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Andrew Benton <b3nt@ukonline.co.uk>, Johannes Stezenbach <js@linuxtv.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Michael Krufky <mkrufky@m1k.net>, video4linux-list@redhat.com
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
In-Reply-To: <42D7BA2F.9070505@brturbo.com.br>
Message-ID: <Pine.LNX.4.61.0507151530200.15841@pub2.ifh.de>
References: <42D77E37.5010908@ukonline.co.uk> <20050715110938.GB9976@linuxtv.org>
 <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de> <42D7B2A0.2040301@ukonline.co.uk>
 <Pine.LNX.4.61.0507151459180.15841@pub2.ifh.de> <42D7BA2F.9070505@brturbo.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Mauro Carvalho Chehab wrote:

> Patrick,
>
> Patrick Boettcher wrote:
>> On Fri, 15 Jul 2005, Andrew Benton wrote:
>>
>>> Hi, I tried the patch but unfortunately the kernel didn't compile, it
>>> ended like this
>>>
>>> CC      drivers/media/video/cx88/cx88-blackbird.o
>>> CC      drivers/media/video/cx88/cx88-dvb.o
>>> drivers/media/video/cx88/cx88-dvb.c:169: error: unknown field
>>> `output_mode' specified in initializer
>>> drivers/media/video/cx88/cx88-dvb.c:176: error: unknown field
>>> `output_mode' specified in initializer
>>
>>
>> Yes, I was in a hurry *slap* and made a mistake.
>>
>> This one is correct (revert the other one):
>
> 	I've already included this on V4L tree.
>
> 	On V4L, we do provide support for older 2.6 releases (so, we have some
> ifdefs to provide backport compatibility that are removed by a script
> before submiting patchsets).
> 	If I understand well your patch, it is to be applied after 2.6.12
> version. Am I right?

Yes. 2.6.13-rc1 introduced the cxusb-driver in the kernel and along with 
it the change in the cx22702.

The cx22702.c from video4linux-CVS is not compatible anymore. Not sure how 
you will handle this? (Throw away the cx22702.c and get it from 
dvb-kernel ;) )

best regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
