Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268826AbTBZQul>; Wed, 26 Feb 2003 11:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbTBZQul>; Wed, 26 Feb 2003 11:50:41 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:1210 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S268826AbTBZQuj>; Wed, 26 Feb 2003 11:50:39 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] Use hex numbers in fs/block_dev.c
Date: Wed, 26 Feb 2003 18:01:55 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
References: <200302261719.15884@bilbo.math.uni-mannheim.de> <20030226163738.GA15555@wohnheim.fh-wedel.de>
In-Reply-To: <20030226163738.GA15555@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200302261801.55432@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. Februar 2003 17:37 schrieb Jörn Engel:
> On Wed, 26 February 2003 17:19:15 +0100, Rolf Eike Beer wrote:
> > We're using hex numbers to identify devices in most places. We should use
> > them in filesystem messages, errors etc. too, this would be much more
> > consistent and avoids things like this where two different naming styles
> > for the same error are used:
> >
> >      end_request: [...] dev 16:45 (hdd), sector 9175248
> >      EXT3-fs error (device ide1(22,69)): [...] inode=575269,
> > block=1146906
> >
> > With this patch the second message would look like this:
> >
> >      EXT3-fs error (device ide1(16:45)): [...] inode=575269,
> > block=1146906
>
> Whis is _horrible_. Am I supposed to guess that ide does not use major
> 16, so it will be 0x16 == 22 instead?

Of course, I know. But then we have to fix the end_request stuff also. And 
root=831 command line etc. This _is_ ugly. I just tried to make it one kind 
of ugly at all.

Eike
