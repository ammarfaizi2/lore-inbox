Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279305AbRKIFXs>; Fri, 9 Nov 2001 00:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRKIFXi>; Fri, 9 Nov 2001 00:23:38 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26100
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279305AbRKIFXe>; Fri, 9 Nov 2001 00:23:34 -0500
Date: Thu, 8 Nov 2001 21:23:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Modutils can't handle long kernel names
Message-ID: <20011108212328.B514@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011108204210.A514@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011108204210.A514@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 08:42:10PM -0800, Mike Fedyk wrote:
> Hello,
> 
> I've gotten into the habbit of adding the names of the patches I add to my
> kernel to the extraversion string in the top level Makefile in my kernels.
> 
> Here's my latest example:
> VERSION = 2
> PATCHLEVEL = 4
> SUBLEVEL = 15
> EXTRAVERSION=-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+ext3-mem_acct+elevator
> 
> Unfortunately, with this long kernel version number, modutils (I've noticed
> depmod and modutils so far...) choke on it.
> 
> depmod:
> depmod: Can't open /lib/modules/2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001/modules.dep for writing
> 
> uname -r:
> 2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001
> 
> uname -a:
> Linux mikef-linux.matchmail.com 2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001 #1 SMP Thu Nov 8 20:18:04 PST 2001 i686 unknown
> 

Oh, /proc/version looks good:
Linux version 2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+ext3-mem_acct+elevator (root@mikef-linux.matchmail.com) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 SMP Thu Nov 8 20:18:04 PST 2001

Mike
