Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSHDL4T>; Sun, 4 Aug 2002 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHDL4T>; Sun, 4 Aug 2002 07:56:19 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:32449 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318161AbSHDL4S>; Sun, 4 Aug 2002 07:56:18 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Tommy Faasen" <faasen@xs4all.nl>
Date: Sun, 4 Aug 2002 22:00:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15693.5974.487891.772395@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 (pre8) strange software raid0 problem
In-Reply-To: message from Tommy Faasen on Sunday August 4
References: <32838.192.168.0.100.1028462137.squirrel@mail.zwanebloem.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 4, faasen@xs4all.nl wrote:
> Hi,
> 
> i ran into a very strange problem.
> 
> I booted my system this morning only to discover that I could no longer
> mount my /dev/md0. I shut down my system last night without any problems.
> 
> The only way I can mount it again is with mdadm --assembly /dev/md0
> /dev/sda9 /dev/sdb1 /dev/sdc1
> I have to do this every time the system is rebooted.
> 
> The distribution is debian unstable
> mdadm - v1.0.1 - 20 May 2002
> raidstart v0.3d compiled for md raidtools-0.90
> 
> Is there any way to permanently fix this error?
> How did this happen, as i didn't do anything i can see related to
> this?

Sounds to me like something changed in debian.  'unstable' is like
that.

It would appear that you aren't using autodetect partitions, so you
need to have either 'raidstart -a' or 'mdadm -As' run at boot time,
with appropriate config files: /etc/raidtab or /etc/mdadm.conf.
Check your rc scripts and config files, decide which one you want to
use, and make sure the right script is enabled and the right
configfile has appropriate information.

NeilBrown
