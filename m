Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUAXX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUAXX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:27:24 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26542 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261731AbUAXX1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:27:20 -0500
Date: Sat, 24 Jan 2004 21:14:56 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
Cc: linux-kernel@vger.kernel.org,
       "XFS: linux-xfs@oss.sgi.com" <linux-xfs@oss.sgi.com>,
       marcelo.tosatti@cyclades.com
Subject: Re: 2.4.24 with the 2.4.23-xfs patches from sgi
In-Reply-To: <4012D258.6010201@mnsu.edu>
Message-ID: <Pine.LNX.4.58L.0401242112340.1274@logos.cnet>
References: <4012D258.6010201@mnsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Jan 2004, Jeffrey E. Hundstad wrote:

> Hello,
>
> In the last 48-hours we've had two machines hang with no messages on the
> console and none in the logs, pings return, drive lights are all off and
> don't ever flash.   Both machines we running linux-2.4.24 with the
> xfs-2.4.23-all-i386 patch as recommended by the XFS group.  These
> machines had been running fine on this kernel image since Jan  13,
> 2004.  One machine was running XFS as a filesystem and the other was
> running EXT2.  These machines have both been in constant production for
> over 4 years and there has not been any hardware changes, including
> those to it's environment with is power and temperature controlled.
>
> Both machines are Pentium-3 class, 256M of memory, both using SCSI disk
> with different SCSI controllers.  This is the the version string:
> Linux version 2.4.24-xfs (j3gum@krypton) (gcc version 2.95.4 20011002
> (Debian prerelease)) #1 SMP Tue Jan 13 22:05:12 CST 2004
>
> If you need more specific info. I'll prob. keep these and the other
> dozen on the same kernel image up for a few more days.

Hi Jeffrey,

There is a known VFS _SMP_ deadlock in 2.4.24. I'm not sure if that is
what you are hitting, but it is likely.

So try 2.4.25-pre7 (which contains an uptodated XFS tree) and check if the
problem goes away.

Please keep me informed.
