Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285089AbRLQKcd>; Mon, 17 Dec 2001 05:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285091AbRLQKcX>; Mon, 17 Dec 2001 05:32:23 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:20876 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S285089AbRLQKcK>; Mon, 17 Dec 2001 05:32:10 -0500
Date: Mon, 17 Dec 2001 12:31:38 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ia64 unaligned accesses in ntfs driver
Message-ID: <20011217123138.L21566@niksula.cs.hut.fi>
In-Reply-To: <20011216191325.K12063@niksula.cs.hut.fi> <20011216124328.E21566@niksula.cs.hut.fi> <20011216191325.K12063@niksula.cs.hut.fi> <20011217090545.N12063@niksula.cs.hut.fi> <5.1.0.14.2.20011217093040.0319a310@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011217093040.0319a310@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Dec 17, 2001 at 09:47:08AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 09:47:08AM +0000, you [Anton Altaparmakov] claimed:
> At 07:05 17/12/01, Ville Herva wrote:
> >I get unaligned accesses from these addresses:
> >
> >kernel unaligned access to 0xe00000006fb49719, ip=0xa000000000265050
> >
> >from ksymoops:
> >Adhoc a000000000265050 <[ntfs]ntfs_decompress+d0/320>
> >Adhoc a000000000262d80 <[ntfs]ntfs_decompress_run+2a0/3c0>
> >Adhoc a000000000262ba0 <[ntfs]ntfs_decompress_run+c0/3c0>
> >Adhoc a000000000262d60 <[ntfs]ntfs_decompress_run+280/3c0>
> >
> >Are these dangerous? I gather IA64 port has some kind of handler for these,
> >since they don't oops.
> 
> They are at least one of the explanations why the driver would not work on 
> non-intel arch... 

It does work (I _was_ surprised) on IA64. I can read the one ntfs partition
quite well. 

> I gather most other arch don't cope with unaligned accesses. I am
> surprised those are the only ones you see actually...

They are not the only ones, I haven't tracked all the entries in dmesg.
 
> This particular function is not implemented correctly anyway - it will not 
> work on BE arch for example (despite all the endian conversion functions, 
> some of which are wrong AFAIK).

I see.
 
> The changes to make the driver clean are too complex and I am not going to 
> bother considering the replacement ntfs driver (ntfs tng available from 
> linux-ntfs cvs on sourceforge) is close to being ready for inclusion into 
> 2.5.x (as soon as read support is completed I will submit it, probably 
> sometime in January). If anyone wants to work on the old driver I am happy 
> to take patches. (-;

Ok. I can give the new driver a shot on IA64 sometime, if I find the time.



-- v --

v@iki.fi
