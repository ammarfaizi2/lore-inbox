Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTBAVSf>; Sat, 1 Feb 2003 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTBAVSf>; Sat, 1 Feb 2003 16:18:35 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:61402 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S264984AbTBAVSe>; Sat, 1 Feb 2003 16:18:34 -0500
Date: Sat, 1 Feb 2003 22:27:17 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: John Bradford <john@grabjohn.com>
Cc: Jon Burgess <Jon_Burgess@eur.3com.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Little endian Cramfs on big endian machines?
Message-ID: <20030201212717.GA32074@wohnheim.fh-wedel.de>
References: <80256CC0.0067A8CA.00@notesmta.eur.3com.com> <200302011929.h11JTMiC010227@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302011929.h11JTMiC010227@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 February 2003 19:29:22 +0000, John Bradford wrote:
> 
> Maybe the native machine endianness is used for performace reasons -
> that would make sense given the typical uses of cramfs.  Also, it is a
> read-only filesystem, so a userland application could flip the
> endianness if a filesystem needs to be used on a non-native endianness
> machine.

Touchy matter.
Having two possible endianness options _will_ cause problems and hours
of lost work, since 50% of all users will get it wrong at least once.
And fixing bugs between keyboard and chair is not a fun job. :)

On the other hand, most filesystem data will be read more than once,
so performance does matter, at least a little.

> I'm not necessarily saying that that it's not a bug, just suggesting
> an explaination.

It is not a bug, it is a tradeoff. Do you want to waste time accessing
the filesystem or fixing so-called bugs and educating the users?

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
