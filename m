Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289192AbSASOV6>; Sat, 19 Jan 2002 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSASOVi>; Sat, 19 Jan 2002 09:21:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11279 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289192AbSASOV3>; Sat, 19 Jan 2002 09:21:29 -0500
Subject: Re: kswapd kills linux box with kernel 2.4.17
To: anishs@vsnl.com
Date: Sat, 19 Jan 2002 14:33:29 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org,
        vda@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <001a01c1a0f0$c8416a50$3c00a8c0@baazee.com> from "Anish Srivastava" at Jan 19, 2002 07:24:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RwYj-0001J3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mem:  8263740K av, 2967608K used, 5296132K free,       0K shrd,    6120K
> buff
> Swap: 2048248K av,       0K used, 2048248K free                 2530948K
> cached
> 
> Now the cached part never gets freed and just keeps piling up & so does the
> used memory.

That is what I would expect up to a point. "Free" memory is wasted memory so
it is better to let all the free memory fill up with any bits of disk data
we have seen and might want again.

What actually matters (and sounds like 2.4.13 didnt do) is that at the point
you need memory for other things like applications and disk buffers that are
relevant to current usage the old stuff should rapidly get replaced by it.

