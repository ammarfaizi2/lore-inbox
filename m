Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270299AbRHRSSS>; Sat, 18 Aug 2001 14:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270300AbRHRSSH>; Sat, 18 Aug 2001 14:18:07 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:46351 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S270299AbRHRSR7>;
	Sat, 18 Aug 2001 14:17:59 -0400
From: Tony Hoyle <tmh@nothing-on.tv>
Subject: Re: 2.4.xx won't recompile.
Date: Sat, 18 Aug 2001 19:18:10 +0100
Organization: cvsnt.org news server
Message-ID: <3B7EB162.5070207@nothing-on.tv>
In-Reply-To: <01081812570001.09229@bits.linuxball> <001901c12810$97ef3a70$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sisko.my.home 998158690 30315 192.168.100.2 (18 Aug 2001 18:18:10 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010810
X-Accept-Language: en-gb, en-us
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Naeslund(f) wrote:

> Isn't it more safe to do it like this:
> 
> make mrproper
> cp ../linux-2.4.8/.config .
> make oldconfig
> make xconfig
> make bzImage && make modules && make modules_install && make install
> 
> ?
> I thought this was the proper way to do it, no?
> 
You don't need to make bzimage first, and you missed the dep/clean steps 
(theoretically not needed any more but I've had some really strange 
compiler errors by missing them out).

cp ../linux-2.4.8/.config .
make oldconfig
make xconfig
make dep clean install modules modules_install

Tony

