Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129446AbRC1Odw>; Wed, 28 Mar 2001 09:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129624AbRC1Odl>; Wed, 28 Mar 2001 09:33:41 -0500
Received: from mail1.upco.es ([130.206.70.227]:13376 "EHLO mail1.upco.es") by vger.kernel.org with ESMTP id <S129446AbRC1Od3>; Wed, 28 Mar 2001 09:33:29 -0500
Date: Wed, 28 Mar 2001 16:32:44 +0200
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328163244.D11584@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.30.0103280115180.7637-100000@coredump.sh0n.net> <Pine.GSO.4.21.0103280815160.26500-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0103280815160.26500-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Mar 28, 2001 at 08:25:46AM -0500
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20 - RGtti 2001-01-29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notice: this is my first post to l-k since some bug report as old as 0.99...
so please be kind, don't beat me to hard.

On Wed, Mar 28, 2001 at 08:25:46AM -0500, Alexander Viro wrote:
 
> <shrug> If you run untrusted binaries - you are screwed.  If you run
> them as root - all users on your system are screwed.  If your MUA
> (or browser, etc.) can run untrusted code - see above. 

Too true. 

But with the new VFS semantics, wouldn't be possible for a MUA to make a
thing like the following: 

spawn a process with a private namespace. Here a minimun subset of the
"real" tree (maybe all / except /dev) is mounted readonly. The private /tmp
and /home/user are substituted by read-write directory that are in the
"real" tree /home/user/mua/fakehome and /home/user/mua/faketmp. In this
private namespace, run the "untrusted" binary. 

Now the binary can do much less harm than before, or am I missing something?
It have no access to real user data, but can use the system library and
services without changing anything in the system. 

Having the read-only flag per vfs-mount is the only kernel-related thing
here, I think; all the rest is simply user-space spice :-). 

Have a nice day,
                   Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 411 132
