Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSGLW0T>; Fri, 12 Jul 2002 18:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318037AbSGLW0S>; Fri, 12 Jul 2002 18:26:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33293 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318036AbSGLW0R>;
	Fri, 12 Jul 2002 18:26:17 -0400
Message-ID: <3D2F57BD.E9ABBBCA@zip.com.au>
Date: Fri, 12 Jul 2002 15:27:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: alan@lxorguk.ukuu.org.uk, matts@ksu.edu, shemminger@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 64 bit netdev stats counter
References: <1026516053.9958.33.camel@irongate.swansea.linux.org.uk> <20020712.150607.35506145.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 13 Jul 2002 00:20:53 +0100
> 
>    gcc will output
> 
>                 increment low 32bit
>                 if zero
>                         increment high
> 
>    Which means we can rapidly get 2^32 out of sync
> 
> True and this equals the "fix" suggested C code involving
> two 32-bit counters that the original author posted :-)
> 

Could you make the counters per-cpu and only add them all up
in the rare case where someone wants to read the stats?

And then change all the drivers ;)

-
