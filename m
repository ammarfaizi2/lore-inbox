Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136470AbRD3HaS>; Mon, 30 Apr 2001 03:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136471AbRD3HaI>; Mon, 30 Apr 2001 03:30:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136470AbRD3HaB>; Mon, 30 Apr 2001 03:30:01 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AED145F.84E95D8D@transmeta.com>
Date: Mon, 30 Apr 2001 00:29:35 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com>
		<Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org> <15085.3587.865614.360094@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> dean gaudet writes:
>  > i was kind of solving a different problem with the code page though -- the
>  > ability to use rdtsc on SMP boxes with processors of varying speeds and
>  > synchronizations.
> 
> A better way to solve that problem is the way UltraSPARC-III do and
> future ia64 systems will, by way of a "system tick" register which
> increments at a constant rate regardless of how the cpus are clocked.
> 
> The "system tick" pulse goes into the processor, so it's still a local
> cpu register being accessed.  Think of it as a system bus clock cycle
> counter.
> 
> Granted, you probably couldn't make changes to the hardware you were
> working on at the time :-)
> 

RDTSC in Crusoe processors does basically this.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
