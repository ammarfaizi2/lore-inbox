Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131868AbRC1O6W>; Wed, 28 Mar 2001 09:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131836AbRC1O6D>; Wed, 28 Mar 2001 09:58:03 -0500
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:57452 "EHLO ead42.ead.dsa.com") by vger.kernel.org with ESMTP id <S131832AbRC1O6A>; Wed, 28 Mar 2001 09:58:00 -0500
Date: Wed, 28 Mar 2001 09:57:06 -0500
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328095706.B834@ead50>
References: <Pine.LNX.4.30.0103280115180.7637-100000@coredump.sh0n.net> <Pine.GSO.4.21.0103280815160.26500-100000@weyl.math.psu.edu> <20010328163244.D11584@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010328163244.D11584@pern.dea.icai.upco.es>; from romano@dea.icai.upco.es on Wed, Mar 28, 2001 at 04:32:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 04:32:44PM +0200, Romano Giannetti wrote:
> But with the new VFS semantics, wouldn't be possible for a MUA to make a
> thing like the following: 
> 
> spawn a process with a private namespace. Here a minimun subset of the
> "real" tree (maybe all / except /dev) is mounted readonly. The private /tmp
> and /home/user are substituted by read-write directory that are in the
> "real" tree /home/user/mua/fakehome and /home/user/mua/faketmp. In this
> private namespace, run the "untrusted" binary. 

Possible and desirable.  You have to turn off access to all the other
dangerous namespaces though, like socket() and shmat(), and make sure
that nosuid and devices are handled properly. Done right, the only thing
that untrusted code can do is consume a little memory, CPU, and disk,
but that's why there are limits and a scheduler. :-)

One might even want to add back limited access to those other namespaces
by implementing a filesystem interface, ala Plan-9/Inferno.

Regards,

   Bill Rugolsky
