Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRBVALm>; Wed, 21 Feb 2001 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRBVALd>; Wed, 21 Feb 2001 19:11:33 -0500
Received: from foobar.napster.com ([64.124.41.10]:60421 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129243AbRBVALS>; Wed, 21 Feb 2001 19:11:18 -0500
Message-ID: <3A9458FD.A87205FC@napster.com>
Date: Wed, 21 Feb 2001 16:10:37 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ookhoi@dds.nl, Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, sim@stormix.com,
        netdev@oss.sgi.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues 
 (3c905B))
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
		<20010221104723.C1714@humilis>
		<14995.40701.818777.181432@pizda.ninka.net>
		<3A9453F4.993A9A74@napster.com> <14996.21701.542448.49413@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Jordan Mendelson writes:
>  > Now, if it didn't have the side effect of dropping packets left and
>  > right after ~4000 open connections (simultaneously), I could finally
>  > move our production system to 2.4.x.
> 
> There is no reason my patch should have this effect.

My guess is that the fast path prevented the need for looking up the
destination in some structure which is limited to ~4K entries (route
table?).


Jordan
