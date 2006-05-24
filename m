Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWEXHQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWEXHQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWEXHQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:16:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9379 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932631AbWEXHQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:16:38 -0400
Date: Wed, 24 May 2006 00:16:00 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: XFS write speed drop
Message-ID: <20060524071600.GF586512@sgi.com>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr> <20060522105326.A212600@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr> <20060523084309.A239136@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr> <20060524082218.A267844@wobbly.melbourne.sgi.com> <20060524091741.D267844@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524091741.D267844@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:17:41AM +1000, Nathan Scott wrote:
> On Wed, May 24, 2006 at 08:22:19AM +1000, Nathan Scott wrote:
> > 
> > Not sure what you're trying to say here.  Yes, barriers are on
> > by default now if the hardware supports them, yes, they will
> > slow things down relative to write-cache-without-barriers, and
> > yes we all knew that ... its not the case that someone "did not
> > notice" or forgot about something.  There is no doubt that this
> > is the right thing to be doing by default - there's no way that
> > I can tell from inside XFS in the kernel that you have a UPS. ;)
> 
> Oh, I realised I've slightly misread your mail, you said...
> 
> | I do not actually need barriers (or an UPS, to poke on another thread),
> | because power failures are rather rare in Germany.
> 
> Hmm, even harder for us to detect at runtime, in the kernel,
> that you're in Germany. :)
>
> Power failures aren't the only thing to cause crashes, however.

There have been several examples of filesystem corruption without
power failures too, though that is a common cause.  It can even happen
on a normal system shutdown if there is no synchronize operation to
the disk at shutdown time, depending on how much data is in the cache
and how long you have until the ATA chip is reset.

jeremy
