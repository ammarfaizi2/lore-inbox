Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWEWWWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWEWWWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWEWWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:22:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48595 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932214AbWEWWWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:22:46 -0400
Date: Wed, 24 May 2006 08:22:19 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: XFS write speed drop
Message-ID: <20060524082218.A267844@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr> <20060522105326.A212600@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr> <20060523084309.A239136@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Tue, May 23, 2006 at 03:23:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 03:23:31PM +0200, Jan Engelhardt wrote:
> >> CASE 1: Copying from one disk to another
> >> ========================================
> >> Copying a compiled 2.6.17-rc4 tree; 306907 KB in 28566 files in 2090
> >> directories.
> >
> >OK, we can call this a metadata intensive workload - lots of small
> >files, lots of creates.  Barriers will hurt the most here, as we'd
> >already have been log I/O bound most likely, and I'd expect barriers
> >to only slow that further.
> >
> Yes and the most important thing is that someone made -o barrier the 
> default and did not notice. Someone else? :-D

Not sure what you're trying to say here.  Yes, barriers are on
by default now if the hardware supports them, yes, they will
slow things down relative to write-cache-without-barriers, and
yes we all knew that ... its not the case that someone "did not
notice" or forgot about something.  There is no doubt that this
is the right thing to be doing by default - there's no way that
I can tell from inside XFS in the kernel that you have a UPS. ;)

cheers.

-- 
Nathan
