Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314139AbSEBAOo>; Wed, 1 May 2002 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314143AbSEBAOn>; Wed, 1 May 2002 20:14:43 -0400
Received: from elin.scali.no ([62.70.89.10]:38418 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S314139AbSEBAOn>;
	Wed, 1 May 2002 20:14:43 -0400
Date: Thu, 2 May 2002 02:14:33 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: "Leech, Christopher" <christopher.leech@intel.com>
cc: "Linux-Kernel (linux-kernel@vger.kernel.org)" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Plan for e100-e1000 in mainline
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1500@orsmsx118.jf.intel.com>
Message-ID: <Pine.LNX.4.30.0205020206420.14581-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002, Leech, Christopher wrote:

>
> > Another funny thing is that the latency for the gigabit
> > adapter (e1000) is also higher than fast ethernet (eepro100)
> > with small messages (<256 bytes) :
>
> You could try setting the RxIntDelay module parameter to 0, that should
> improve round trip latency.  The balance between latency on the receive path
> and interrupt rate can be difficult to manage, hopefully a dynamic method
> like NAPI will result in Ethernet drivers that need less hand tuning.
>

Hmm the docs say that RxIntDelay is by default 0 but when I tried it, it
helped for sure (although the numbers are still a bit higher that with
eepro100).

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

