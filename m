Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTBQSMe>; Mon, 17 Feb 2003 13:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBQSMe>; Mon, 17 Feb 2003 13:12:34 -0500
Received: from AGrenoble-101-1-1-67.abo.wanadoo.fr ([193.251.23.67]:7059 "EHLO
	awak") by vger.kernel.org with ESMTP id <S267268AbTBQSMd>;
	Mon, 17 Feb 2003 13:12:33 -0500
Subject: Re: ext3 clings to you like flypaper
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bourne <jbourne@mtroyal.ab.ca>
In-Reply-To: <9850000.1045504008@[10.10.2.4]>
References: <78320000.1045465489@[10.10.2.4]>
	 <1045482621.29000.40.camel@passion.cambridge.redhat.com>
	 <2460000.1045500532@[10.10.2.4]>
	 <20030217170851.GA18693@wohnheim.fh-wedel.de>
	 <9850000.1045504008@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1045506119.32207.16.camel@bip.localdomain.fake>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 19:22:00 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 17/02/2003 à 18:46, Martin J. Bligh a écrit :
> >> The point remains, if I say I want ext2, I should get ext2, not whatever 
> >> some random developer decides he thinks I should have. Worst of all,
> >> the system then lies to you and says it's mounted ext2 when it's not.
> > 
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

You can't remount to a different filesystem type. You would have to play
games with pivot_root(), mount root once under each fs type and be sure
every fd is closed (even those from /dev/*) before unmounting the first
instance. Basically not manageable.

	Xav

