Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSGQQ1C>; Wed, 17 Jul 2002 12:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSGQQ1C>; Wed, 17 Jul 2002 12:27:02 -0400
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:54927 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id <S315375AbSGQQ1B>; Wed, 17 Jul 2002 12:27:01 -0400
Date: Wed, 17 Jul 2002 12:29:55 -0400
From: Jason Lunz <lunz@reflexsecurity.com>
To: zhengchuanbo <zhengcb@netpower.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to improve the throughput of linux network
Message-ID: <20020717162955.GA8858@reflexsecurity.com>
References: <200207172216104.SM00792@zhengcb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207172216104.SM00792@zhengcb>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
> i got the patch for NAPI,and patched it on linux2.4.18. it worked. the
> throughput of 128bytes frame improve from 60% to more than 90%. it
> seems that it has no influnce to frames bigger than 256.
> 
> but there is still some problem. when i tested the throught of 64bytes
> frame,some error occured. in the begining it works well. but after
> several times of try the linux router can not receive any packets at
> all.(i found that by run ifconfig when the smartbits is testing). for
> the other frames it worked very well.
> 
> so what's wrong with my test? is there some problem with the patch?

Quite possibly. Are you still using the eepro100 NAPI driver? I doubt
that it's gotten wide testing.

The patch at http://gtf.org/lunz/linux/net/ comes from here:
ftp://robur.slu.se/pub/Linux/net-development/NAPI/eepro100/eepro100-napi-020619.tar.gz

The NAPI conversion was done by fxzhang@ict.ac.cn (see the README); you
may want to ask him about problems you're having.

-- 
Jason Lunz			Reflex Security
lunz@reflexsecurity.com		http://www.reflexsecurity.com/
