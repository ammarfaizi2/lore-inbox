Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275798AbRJNRKL>; Sun, 14 Oct 2001 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275790AbRJNRKB>; Sun, 14 Oct 2001 13:10:01 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:2708 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275789AbRJNRJn>; Sun, 14 Oct 2001 13:09:43 -0400
Date: Sun, 14 Oct 2001 20:09:57 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
Message-ID: <20011014200957.S1074@niksula.cs.hut.fi>
In-Reply-To: <20011014191218.Q1074@niksula.cs.hut.fi> <Pine.GSO.4.21.0110141217000.6026-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110141217000.6026-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Oct 14, 2001 at 12:20:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 12:20:34PM -0400, you [Alexander Viro] claimed:
> 
> 
> On Sun, 14 Oct 2001, Ville Herva wrote:
> 
> > BTW, I just managed get a mount process to unkillable (-9) state while
> > playing with --bind. You might be uninterested in details if I can figure
> > out how to reproduce it?
> 
> I would be _very_ interested in details.  A word of warning, though -
> /proc/mounts is b0rken.  If its output grows beyond 4Kb (no matter what
> had caused that - lots of NFS mounts, many bindings, etc.) it silently
> truncates the output.  Result: deeply confused umount -a.
> 
> I'll post the fix as soon as I finish it.  For now too many mountpoints
> of any description == confused df and umount -a.

$ wc -c /proc/mounts 
    663 /proc/mounts

In this case the /proc/mounts seems not to be the problem. Also, mount out
put is sane and further mount commands succeed.

 
-- v --

v@iki.fi
