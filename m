Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTATUvp>; Mon, 20 Jan 2003 15:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTATUvo>; Mon, 20 Jan 2003 15:51:44 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:13582 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266286AbTATUvn>; Mon, 20 Jan 2003 15:51:43 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: trond.myklebust@fys.uio.no, ultralinux@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: strange sparc64 -> i586 intermittent but reproducible NFS write errors to one and only one fs
References: <87bs2q3paq.fsf@amaterasu.srvr.nix>
	<200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
	<87iswkx53u.fsf@amaterasu.srvr.nix>
	<15915.4574.380686.123067@charged.uio.no>
	<1043044714.10408.0.camel@rth.ninka.net>
X-Emacs: you'll understand when you're older, dear.
From: Nix <nix@esperi.demon.co.uk>
Date: 20 Jan 2003 20:53:00 +0000
In-Reply-To: <1043044714.10408.0.camel@rth.ninka.net>
Message-ID: <87y95fv903.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2003, David S. Miller muttered drunkenly:
> On Sun, 2003-01-19 at 13:00, Trond Myklebust wrote:
>> It sounds rather strange that this particular patch should introduce
>> an EIO, but here it is (fresh from BitKeeper)
> 
> It is possible in the context of the change causing a miscompile.
> Another possibility is just timing differences causing different
> sequences of events to occur than before.

I'll be rebooting with -pre10-minus-Trond's-patch later tonight, and
tcpdumping the NFS conversation to death if it hasn't been cured.

FWIW, the MTU on the subnet that both these machines are on has MTU
576. I really doubt this affects anything; I mention it merely because
it's a bit unusual on Ethernet networks. And all these FSen are mounted
with -o defaults,rsize=8192,wsize=8192.

I think the problem *must* be somehow timing-related; I can't see
anything else that could cause writes to fail when writing to one
NFS-exported filesystem but not to another (of the same type) on the
same machine, save that the two fsen are on different physical disks
which have rather different timing characteristics.

(Either that or the machine just hates me.)

-- 
`I knew that there had to be aliens somewhere in the universe.  What I
 did not know until now was that they read USENET.' --- Mark Hughes,
      on those who unaccountably fail to like _A Fire Upon The Deep_
