Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135724AbREIWaT>; Wed, 9 May 2001 18:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135760AbREIWaK>; Wed, 9 May 2001 18:30:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:45838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135724AbREIW3u>; Wed, 9 May 2001 18:29:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] make distclean tries to delete dirs in tmpfs
Date: 9 May 2001 15:29:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dcgc8$ora$1@cesium.transmeta.com>
In-Reply-To: <20010509204434.Q754@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010509204434.Q754@nightmaster.csn.tu-chemnitz.de>
By author:    Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
In newsgroup: linux.dev.kernel
> 
> make distclean deletes anything with size 0. This includes
> directories, while making the kernel in tmpfs or ramfs.
> 

Wouldn't it be better to fix tmpfs/ramfs to report something sensible,
even if it's artificial?  Perhaps reporting the cardinality of the
directory, if that happens to be easily available.

N.B.: X/KDE will not run on a ramfs, because it reports as a size-zero
filesystem in "df".  Switching to tmpfs solved that for me.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
