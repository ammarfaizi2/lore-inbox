Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTLTEcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 23:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTLTEcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 23:32:18 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:18332 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263806AbTLTEcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 23:32:16 -0500
Message-ID: <3FE3D0CB.603@cyberone.com.au>
Date: Sat, 20 Dec 2003 15:32:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Meder <chris@onestepahead.de>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
References: <1071864709.1044.172.camel@localhost>	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>	 <200312201355.08116.kernel@kolivas.org>	 <1071891168.1044.256.camel@localhost>  <3FE3C6FC.7050401@cyberone.com.au> <1071893802.1363.21.camel@localhost>
In-Reply-To: <1071893802.1363.21.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Meder wrote:

>On Sat, 2003-12-20 at 04:50, Nick Piggin wrote:
>
>>(although not much Con)
>>
>
>right. Ok I'm running now 2.6.0 with Nick's v28p1: The results without
>load and with kernel compile load are attached. On nice level 0 I get
>now the stuttering sound which I described in the previous mail. When I
>renice gnomemeeting to -10 it's actually usable but not as good as in
>2.4.2x. It's still sensitive to window movement and X activity. Two
>subjective observations are that the nice levels haven't got such a big
>impact in Nick's scheduler they used to have and that the default
>behaviour gnomemeetingwise is better than in earlier Nick schedulers.
>

No, nice levels don't have such a big impact. That is the last big
think I have to fix, but thats another story...

At nice -10, there is basically nothing more the scheduler can do
for it (nice -20 will be a tiny bit better again).

I'd say its due to either sound drivers or your app doing something
different when running in 2.6.

>
>
>>This might be a problem - try turning unmaskirq on, and possibly
>>32-bit IO support on (hdparm -u1 -c1 /dev/hda). I think there is
>>a remote possibility that doing this will corrupt your data just
>>to let you know.
>>
>
>Tried it and doesn't make a difference.
>

dang

>
>>So the 1 gnomemeeting process is doing everything? (except display of 
>>course)
>>
>
>AFAIK yes.
>
>

