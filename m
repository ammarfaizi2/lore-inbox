Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSIEAGI>; Wed, 4 Sep 2002 20:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSIEAGI>; Wed, 4 Sep 2002 20:06:08 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:36494 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316672AbSIEAGH>; Wed, 4 Sep 2002 20:06:07 -0400
Date: Thu, 5 Sep 2002 01:09:10 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gabriel Paubert <paubert@iram.es>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
Message-ID: <20020905010910.A14236@kushida.apsleyroad.org>
References: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es> <1031181438.3017.125.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1031181438.3017.125.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 05, 2002 at 12:17:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-09-04 at 23:39, Gabriel Paubert wrote:
> > While it would work, this sequence is overkill. Unless I'm mistaken, the
> > only property of bswap which is used in this case is that it swaps even
> > and odd bytes, which can be done by a simple "roll $8,%eax" (or rorl).
> 
> bswap is a 32bit swap. 

Yes it's different from the roll $8, but if all you need is to swap odd
and even bytes for the IP checksum, either instruction is fine.

-- Jamie
