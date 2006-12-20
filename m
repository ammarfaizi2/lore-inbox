Return-Path: <linux-kernel-owner+w=401wt.eu-S1030267AbWLTS5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWLTS5g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWLTS5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:57:36 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:52963 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030267AbWLTS5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:57:35 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45898785.4000209@s5r6.in-berlin.de>
Date: Wed, 20 Dec 2006 19:57:09 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458913AC.7080300@s5r6.in-berlin.de> <45897478.6070308@redhat.com>
In-Reply-To: <45897478.6070308@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Stefan Richter wrote:
>> Actually there are also eth1394 and pcilynx to be pulled over. Eth1394
>> should be quite easy to do for anybody after iso reception is settled in
>> your stack. Pcilynx could follow depending on developer interest. It's
>> increasingly rare hardware and the few old machines which have it can be
>> cheaply upgraded to OHCI (which performs better for SBP-2 anyway).
> 
> Well... I don't think eth1394 was ever used much and it's not something
> I plan to port over.

It is used, even though it is not very robust because it is not actively
maintained (yet). If your stack will shape up to become a potential
replacement of mainline's stack, I'm sure _someone_ will do the port.

> The only thing I've ever heard people say about it
> is that it's annoying because it screws up their network interface
> ordering.

Yeah, the same way hot-pluggable SCSI devices screw up device naming of

> And Windows Vista will drop the IP over 1394 functionality,
> which is another data point about how widely used this standard is.

If we cared what Windows supports or does not support, we would have gap
count optimization by now, but no support of IEEE 1394b-2002.

> I'm not planning to port the pcilynx driver either.  I think it's a sore
> point for the old stack as it is - nobody uses it or tests it and it's
> continously bit-rotting.  So I'd rather not support it.

Here I agree.

> However, it can
> perform as well as an OHCI card for SBP-2.  If you set up a
> self-modifying DMA program it can read and write system memory without
> CPU intervention too.

OK, I didn't know that although I suspected something like this might be
possible. Of course this remains a potential feature as long as there is
no manpower to actually implement it. (Nor is there a userbase to speak
of to appreciate such an effort.)

>>>  - Make a libraw1394 compatibility library
>>
>> Consider using libraw1394 right from the start of this porting project.
>> If there is only one libraw1394 (which works with raw1394 and with
>> fw-device-cdev), enthusiasts might have an easier time to test your
>> stack.
> 
> Hmm, maybe.  There is going to be completely different code paths for
> each API entry point and not a lot of code sharing.  But there is
> definitely some merit to only having one library, and if it could detect
> the kernel interface automatically and just work that would be even better.

Certainly, there won't be any benefit WRT code sharing in the library.
It's more about deployment.
-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
