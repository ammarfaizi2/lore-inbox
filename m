Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSIJTjt>; Tue, 10 Sep 2002 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSIJTjt>; Tue, 10 Sep 2002 15:39:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318075AbSIJTjs>;
	Tue, 10 Sep 2002 15:39:48 -0400
Message-ID: <3D7E4B7F.5030008@mandrakesoft.com>
Date: Tue, 10 Sep 2002 15:43:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Oliver Xymoron <oxymoron@waste.org>, "David S. Miller" <davem@redhat.com>,
       david-b@pacbell.net, mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <Pine.LNX.4.44.0209101236270.7106-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 10 Sep 2002, Oliver Xymoron wrote:
> 
>>Which still leaves the question, does it really make sense for
>>FATAL/BUG to forcibly kill the machine?
> 
> 
> No. It should only be "locally fatal", and it should clearly just do what 
> BUG() does now - kill the process.
> 
> But that implies very much that you really cannot use FATAL() in general
> at all, since it would be illegal to use whenever some caller holds some
> non-local locks (which is almost always the case for most "peripheral
> code").


Well we still have panic()...  It might be nice to have a PANIC() macro 
with a similar form to that of DEBUG/WARN/FATAL...

