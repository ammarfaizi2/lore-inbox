Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRBUXuV>; Wed, 21 Feb 2001 18:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRBUXuM>; Wed, 21 Feb 2001 18:50:12 -0500
Received: from foobar.napster.com ([64.124.41.10]:40207 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129669AbRBUXtg>; Wed, 21 Feb 2001 18:49:36 -0500
Message-ID: <3A9453F4.993A9A74@napster.com>
Date: Wed, 21 Feb 2001 15:49:08 -0800
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
		<20010221104723.C1714@humilis> <14995.40701.818777.181432@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Ookhoi writes:
>  > We have exactly the same problem but in our case it depends on the
>  > following three conditions: 1, kernel 2.4 (2.2 is fine), 2, windows ip
>  > header compression turned on, 3, a free internet access provider in
>  > Holland called 'Wish' (which seemes to stand for 'I Wish I had a faster
>  > connection').
>  > If we remove one of the three conditions, the connection is oke. It is
>  > only tcp which is affected.
>  > A packet on its way from linux server to windows client seems to get
>  > dropped once and retransmitted. This makes the connection _very_ slow.
> 
> :-( I hate these buggy systems.
> 
> Does this patch below fix the performance problem and are the windows
> clients win2000 or win95?

Just a note however... this patch did fix the problem we were seeing
with retransmits and Win95 compressed PPP and dialup over earthlink in
the bay area.

Now, if it didn't have the side effect of dropping packets left and
right after ~4000 open connections (simultaneously), I could finally
move our production system to 2.4.x.



Jordan
