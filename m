Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293588AbSBZLwS>; Tue, 26 Feb 2002 06:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293589AbSBZLwI>; Tue, 26 Feb 2002 06:52:08 -0500
Received: from fwext.dif.dk ([130.227.136.2]:28400 "EHLO DIFPST1A.dif.dk")
	by vger.kernel.org with ESMTP id <S293588AbSBZLvu>;
	Tue, 26 Feb 2002 06:51:50 -0500
Subject: Re: ISO9660 bug and loopback driver bug
From: Jesper Juhl <jju@dif.dk>
To: Barubary <barubary@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D>
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 26 Feb 2002 12:54:01 +0100
Message-Id: <1014724445.5666.2.camel@jju_lnx>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 12:37, Barubary wrote:
> First, the ISO9660 bug.  The ISO file system driver in Linux doesn't handle
> leap years correctly.  It assumes all years divisible by 4 are leap years,
> which is incorrect.  For those that don't know the right algorithm, all
> years that (are divisible by 4) and ((not divisible by 100), or (divisible
> by 400)) are leap years.  ISO file dates on or after March 1, 2100 will be 1
> day off when viewed under Linux as a result.  The bug is in fs/isofs/util.c,
> function iso_date().  This is a very low priority bug, because a) nobody
> cares about ISO file date accuracy including me; and b) it shouldn't matter
> until 2100.  Anyone bored enough to fix this? :)  I guess I could do it...
> 

I'll fix it. I'm still learning about the kernel, and fixing small bugs
is a good way to learn - and this one is on a scale I can handle. :-)

I'll look at it tonight and mail a patch to lkml as soon as the work is
done.


> Now the loopback bug.  Files whose size is greater than 2^31-1 don't work
> with the loopback driver.  It fails with strange errors, like "device not
> found".  This bug prevents DVD-ROM .iso files from being mounted as either
> UDF or ISO file systems - the particular use I encountered it with.  It's a
> bit higher of a priority than the ISO9660 date bug, because it prevents
> useful features from working.  Still not too important though.
> 

I'll give this one a shot as well, but I'm not yet sure I'm up to it -
will have to look at the code first. :)


-- 
Mvh. / Best regards
Jesper Juhl - jju@dif.dk


