Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278815AbRJaBPU>; Tue, 30 Oct 2001 20:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278832AbRJaBPQ>; Tue, 30 Oct 2001 20:15:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9206
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278815AbRJaBOs>; Tue, 30 Oct 2001 20:14:48 -0500
Date: Tue, 30 Oct 2001 17:15:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "P.Agenbag" <internet@mweb.co.za>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and reiserfs / patches
Message-ID: <20011030171519.G490@mikef-linux.matchmail.com>
Mail-Followup-To: "P.Agenbag" <internet@mweb.co.za>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BDEF62B.5050600@mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDEF62B.5050600@mweb.co.za>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 08:49:15PM +0200, P.Agenbag wrote:
> Hmm, very stupid question...
> Firstly, thanks to all the responses helping me to get the 
> (EXPERIMENTAL) out of the way...
> Now, is reiserfs the same as ext3? if not, what's the diff/best?
>

That is a religous question here for some people.  There are several
different opinions.  Some say they use abcFS for this feature, and others
say that that feature has already been though of and passed over for a
better solution...

> Also, concerning the patches
> 
> I only once attempted to patch a kernel and it came out a beeeeeg 
> messup. I'm not very sure about the procedure, I always untar my new 
> kernel in /opt and then rename the linux folder to the version number ( 
> sometimes have 4 or 5 kernels, so need to distinguish...)

I tend to rename the directory with a descriptive name of which patches are
applied.

$ ls /usr/src/lk2.4
2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap

Also, I modify the toplevel makefile file to reflect which patches are
applied.  This way, each kernel has its' own set of modules too, which can
be important because some patches will make ther modules incompatible.

$ head 2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap/Makefile
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 13
EXTRAVERSION = freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap

$ ls /lib/modules/
2.2.20pre10_raid-2219A1_ext3-007a_eide-05042001
2.4.10-ac10-smp-preempt
2.4.10-ac11+smp+preempt+vm_hogstop
2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2
2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2+account-rand-cleanup
2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache
2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap

> Lets say I have a  /opt/247 kernel source , how exactly would I patch it 
> and with which of the patches? Do you patch the 247 kernel with the 247 
> patch, or do you patch it with a higher version, and if so, how many 
> "steps" can you go higher?
> 

If you have 2.4.0 you patch it with the 2.4.1-patch.  You can keep going
with 2.4.2, 2.4.3, etc.  As long as you have the next consecutive patch you
can go forever.

If you wanted to, you could patch all the way from 2.0.0 up to 2.4.13 with
enough steps.  Though, you'd probably kill your hard drive... ;)

> Sorry for the ignorance, but hey, atleast i'm willing to learn!
> Thanks

Questions like these are why we have www.kernelnewbies.org, and the kernel
faq which is listed at the bottom of this and every message.

Mike
