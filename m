Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTBQSVY>; Mon, 17 Feb 2003 13:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTBQSVY>; Mon, 17 Feb 2003 13:21:24 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:11935 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267275AbTBQSVX>; Mon, 17 Feb 2003 13:21:23 -0500
Date: Mon, 17 Feb 2003 19:31:13 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bourne <jbourne@mtroyal.ab.ca>
Subject: Re: ext3 clings to you like flypaper
Message-ID: <20030217183113.GA24922@wohnheim.fh-wedel.de>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com> <2460000.1045500532@[10.10.2.4]> <20030217170851.GA18693@wohnheim.fh-wedel.de> <9850000.1045504008@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9850000.1045504008@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 February 2003 09:46:51 -0800, Martin J. Bligh wrote:
> 
> >> The point remains, if I say I want ext2, I should get ext2, not whatever 
> >> some random developer decides he thinks I should have. Worst of all,
> >> the system then lies to you and says it's mounted ext2 when it's not.

You appear to not have /etc/mtab as a symlink to /proc/mounts. One of
the first things I do on fresh debian installations. The kernel should
know better than some file, especially when / is mounted ro.

> > This is, how things worked for me:
> > 1. Kernel tries to mount rootfs ext3. If this fails, it will continue
> > trying ext2. No other fs compiled into kernel.
> > 2. If there is a journal, it is ext3.
> > 3. Init scripts read /etc/fstab and read ext2.
> > 4. root is remounted as ext2.
> > 5. System allows me to log it, root is ext2, life is good.
> > 
> > Where is your behaviour different from this list? Where do you say you
> > want ext2 but don't get it?
> 
> That's what I'd expect to happen ... as others have pointed out, it may
> be a distro issue ... do you have the snippet of the init scrips that
> do the remount as ext2 to hand? Maybe debian is just broken ...

My broken memory tells me that Debian is working quite fine. The code
in question should be in /etc/init.d/checkroot.sh in your system.

But my eye does not find the spot, where / is remounted with a
different type. This is strange! I've often been surprised that adding
a journal and putting ext3 support in the kernel without editing
/etc/fstab was not enough.

I should test it again to prove my eye wrong.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
