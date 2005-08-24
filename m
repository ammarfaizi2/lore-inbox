Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVHXVWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVHXVWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVHXVWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:22:50 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:15790 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932257AbVHXVWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:22:49 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 14:22:15 -0700
User-Agent: KMail/1.8.2
Cc: Andy Isaacson <adi@hexapodia.org>,
       moreau francis <francis_moreau2000@yahoo.fr>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com> <200508241253.53586.jbarnes@virtuousgeek.org> <1124919935.13833.3.camel@localhost.localdomain>
In-Reply-To: <1124919935.13833.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508241422.15751.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 24, 2005 2:45 pm, Alan Cox wrote:
> And in more detail from the deviceiobook..
>
>       <para>
>         In addition to write posting, on some large multiprocessing
> systems
>         (e.g. SGI Challenge, Origin and Altix machines) posted writes
> won't
>         be strongly ordered coming from different CPUs.  Thus it's
> important
>         to properly protect parts of your driver that do memory-mapped
> writes
>         with locks and use the <function>mmiowb</function> to make
> sure they
>         arrive in the order intended.  Issuing a regular
> <function>readX </function> will also ensure write ordering, but
> should only be used
>         when the driver has to be sure that the write has actually
> arrived
>         at the device (not that it's simply ordered with respect to
> other
>         writes), since a full <function>readX</function> is a
> relatively expensive operation.
>       </para>

Yeah, wrote that too :).  io_ordering.txt should probably just get folded 
into deviceiobook at some point...  Or we could just replace both with 
URL pointers to LDD vol. 3. ;)

Jesse
