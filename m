Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTBMDw2>; Wed, 12 Feb 2003 22:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTBMDw2>; Wed, 12 Feb 2003 22:52:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267765AbTBMDw0>;
	Wed, 12 Feb 2003 22:52:26 -0500
Message-ID: <32910.4.64.238.61.1045108917.squirrel@www.osdl.org>
Date: Wed, 12 Feb 2003 20:01:57 -0800 (PST)
Subject: Re: [Ext2-devel] Re: fsck out of memory
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <peter@chubb.wattle.id.au>
In-Reply-To: <15947.4435.829168.530565@wombat.chubb.wattle.id.au>
References: <5250726@toto.iv>
        <15947.4435.829168.530565@wombat.chubb.wattle.id.au>
X-Priority: 3
Importance: Normal
Cc: <sct@redhat.com>, <raid@a2000.nu>, <adilger@clusterfs.com>,
       <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <tytso@mit.edu>, <tbm@a2000.nu>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> "Stephen" == Stephen C Tweedie <sct@redhat.com> writes:
>
> Stephen> Hi, On Tue, 2003-02-11 at 13:11, Stephan van Hienen wrote:
>
> Stephen> I've no idea.  Ben has some lb patches up at
>
> Stephen>   http://people.redhat.com/bcrl/lb/
>
> Stephen> but there's nothing broken out against the latest lbd diffs.
>
>
> Ben's patches are against a very old version of the kernel (2.4.6-pre8) and
> require linking against libgcc to get 64-bit division.
>
>
> The main issue is 64-bit division.  In the limited time I had I
> couldn't convince myself that I could rely on all divisors being less than
> 2^31 in the raid4/5 code.  If you can convince yourself of that, then t's a
> straightforward but tedious task to make raid1, raid4 and raid5 LBD-safe.
> --

Hi,
Is this in a speed-sensitive area?
If not, you could consider 64-bit software divide functions, such as found at
http://nemesis.sourceforge.net/browse/lib/static/intmath/ix86/intmath.c.html,
which would only be used on 32-bit CPUs, of course.

--
~Randy



