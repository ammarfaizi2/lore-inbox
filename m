Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268798AbTB0AC1>; Wed, 26 Feb 2003 19:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbTB0AC1>; Wed, 26 Feb 2003 19:02:27 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:60427 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S268798AbTB0AC0>; Wed, 26 Feb 2003 19:02:26 -0500
Date: Wed, 26 Feb 2003 16:12:40 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use hex numbers in fs/block_dev.c
Message-ID: <20030227001240.GC15254@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200302261719.15884@bilbo.math.uni-mannheim.de> <20030226163738.GA15555@wohnheim.fh-wedel.de> <200302261801.55432@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302261801.55432@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 06:01:55PM +0100, Rolf Eike Beer wrote:
> Am Mittwoch, 26. Februar 2003 17:37 schrieb Jörn Engel:
> > On Wed, 26 February 2003 17:19:15 +0100, Rolf Eike Beer wrote:
> > > We're using hex numbers to identify devices in most places. We should use
> > > them in filesystem messages, errors etc. too, this would be much more
> > > consistent and avoids things like this where two different naming styles
> > > for the same error are used:
> > >
> > >      end_request: [...] dev 16:45 (hdd), sector 9175248
> > >      EXT3-fs error (device ide1(22,69)): [...] inode=575269,
> > > block=1146906
> > >
> > > With this patch the second message would look like this:
> > >
> > >      EXT3-fs error (device ide1(16:45)): [...] inode=575269,
> > > block=1146906
> >
> > Whis is _horrible_. Am I supposed to guess that ide does not use major
> > 16, so it will be 0x16 == 22 instead?
> 
> Of course, I know. But then we have to fix the end_request stuff also. And 
> root=831 command line etc. This _is_ ugly. I just tried to make it one kind 
> of ugly at all.

If you are going to print it in hex do make it clear but one
0x should be enough: 0x16:45 is OK, 0x16:0x45 is hideous.

Given that the way i would identify device would be to grep
for the numbers in an ls of /dev i'd much rather they be in
decimal.  It all depends on how people will use the values.
When would i use the hex representation be useful?

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
