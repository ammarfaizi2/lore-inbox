Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271597AbRHUJEr>; Tue, 21 Aug 2001 05:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRHUJEg>; Tue, 21 Aug 2001 05:04:36 -0400
Received: from ns0.inpharmatica.com ([193.115.214.5]:53510 "EHLO
	gallions-reach.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S271597AbRHUJEY>; Tue, 21 Aug 2001 05:04:24 -0400
Message-ID: <3B8223A8.70900@purplet.demon.co.uk>
Date: Tue, 21 Aug 2001 10:02:32 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jay@rgrs.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() says closed socket readable
In-Reply-To: <200108181627.UAA19351@ms2.inr.ac.ru>	<E15Yq81-0006o8-00@shell2.shore.net> <20010820.080334.68038516.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Jay Rogers <jay@rgrs.com>
>    Date: Mon, 20 Aug 2001 10:34:09 -0400
> 
>    > Right. It does not block on read, hence it is readable.
>    
>    No, a socket that's never been connected isn't readable, hence
>    select() shouldn't be returning a value of 1 on it.
> 
> You may read without blocking, select() returns 1.

By this logic a socket that is set non-blocking should always be
treated as readable. I think we can all agree that argument is
flawed :-).


The prevailing view from other systems appears to be that reading
from an unconnected (or unconnectING) socket is meaningless so
the socket is not readable.

Presumably there is a damn good reason, or a standards reference,
why that is the wrong behaviour and should be changed?

				Mike

