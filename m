Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSG3T1t>; Tue, 30 Jul 2002 15:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSG3T1s>; Tue, 30 Jul 2002 15:27:48 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:26232 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S315942AbSG3T1r>; Tue, 30 Jul 2002 15:27:47 -0400
Date: Tue, 30 Jul 2002 14:31:11 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Buddy Lumpkin <b.lumpkin@attbi.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
Message-ID: <20020730143111.B8157@hexapodia.org>
References: <FJEIKLCALBJLPMEOOMECOEPFCPAA.b.lumpkin@attbi.com> <1027813211.21516.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1027813211.21516.2.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 28, 2002 at 12:40:11AM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 12:40:11AM +0100, Alan Cox wrote:
> On Sat, 2002-07-27 at 23:22, Buddy Lumpkin wrote:
> > I thought linux worked more like Solaris where it didn't use any swap (AT
> > ALL) until it has to... At least, I hope linux works this way.
> 
> I'd be suprised if Solaris did something that dumb.
> 
> You want to push out old long unaccessed pages of code to make room for
> more cached disk blocks from files.

... unless the disk blocks are coming in due to a sequential stream
that's much larger than memory, in which case paging out user data to
expand the buffer cache is an exercise in futility that makes the system
behave sluggishly long AFTER the stream is done streaming through.

I see this behavior every morning after the nightly backup is done
(pulling in about 20 GB of data on a 256MB machine) -- my window manager
and browser are absurdly sluggish for about 20 seconds.

-andy
