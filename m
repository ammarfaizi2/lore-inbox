Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbREWXqI>; Wed, 23 May 2001 19:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263322AbREWXp6>; Wed, 23 May 2001 19:45:58 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:12556 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S263321AbREWXpq>;
	Wed, 23 May 2001 19:45:46 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Wed, 23 May 2001 17:45:41 -0600
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
Message-ID: <20010523174541.A457@wintermute.starfire>
In-Reply-To: <20010523172326.A898@wintermute.starfire> <Pine.GSO.4.21.0105231927090.20269-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.4.21.0105231927090.20269-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, May 23, 2001 at 07:28:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 07:28:14PM -0400, Alexander Viro wrote:
> 
> 
> On Wed, 23 May 2001, Maciek Nowacki wrote:
> 
> > On Wed, May 23, 2001 at 06:21:23PM -0400, Alexander Viro wrote:
> > I wrote out the contents of /dev/rd/0 a few times and diff'ed with the
> > uncompressed image of the initrd on the server. No difference each time. The
> > same after digging into swap, turning off swap, running blockdev --flushbufs
> > several times (always with BLKFLSBUF: Device or resource busy).
> > 
> > The next test will be to create an initrd that has the 'initrd' directory..
> 
> Not initrd with /initrd in it, final root with /initrd, so that change_root()
> had a place to remount the thing on.

Yeah, but.. I get the message about change_root() before I have a chance to
do anything (there is no /linuxrc on my initrd). I could try with a linuxrc,
but I wanted to avoid that since since it seemed to be becoming obsolete.

Maciek
