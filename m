Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264744AbRFTH2S>; Wed, 20 Jun 2001 03:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRFTH2I>; Wed, 20 Jun 2001 03:28:08 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:30217 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S264744AbRFTH16>; Wed, 20 Jun 2001 03:27:58 -0400
Date: Wed, 20 Jun 2001 10:27:51 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: random errors with bzip2
Message-ID: <20010620102751.M1503@niksula.cs.hut.fi>
In-Reply-To: <lxiths7aqf.fsf@pixie.isr.ist.utl.pt> <20010619181148.A24734@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010619181148.A24734@telia.com>; from andre.dahlqvist@telia.com on Tue, Jun 19, 2001 at 06:11:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 06:11:48PM +0200, you [André Dahlqvist] claimed:
> Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
> 
> > - it could be a memory problem, but if it were, lots of kernel
> > oops were expected, right?
> 
> This certainly sounds like a memory problem. I experienced almost the same
> behaviour with a box some years ago, and it turned out to be memory. The
> kernel didn't oops, and I actually had to run several kernel compiles at
> the same time to have gcc die.
> 
> Try memtest86 on the suspect box.

Seconded.

Exactly the same symptoms (bzip2); the culprit turned out to be memory.

That's when I wrote memburn (http://v.iki.fi/~vherva/memburn.c) for quick
testing without a boot (it did find the problem) and I then verified the
problem with memtest86 (http://reality.sgi.com/cbrady_denver/memtest86/).
You do have to run either for hours, propably for days to be sure. 

The box has now ran perfectly for a year or so with the BadRam patch from
Rick van Rein (http://rick.vanrein.org/linux/badram/).


-- v --

v@iki.fi
