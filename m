Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUBXGLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 01:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbUBXGLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 01:11:31 -0500
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:15886 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262176AbUBXGL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 01:11:28 -0500
Subject: Re: 2.6.3 oops at kobject_unregister, alsa & aic7xxx
From: Eric Kerin <eric@bootseg.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20040223160716.799195d0.akpm@osdl.org>
References: <1077546633.362.28.camel@boxen>
	 <20040223160716.799195d0.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1077602725.3172.19.camel@opiate>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 24 Feb 2004 01:05:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-23 at 19:07, Andrew Morton wrote:
> Alexander Nyberg <alexn@telia.com> wrote:
> >
> > This happens at shutdown when alsa is to close down. I'm running debian
> > sid. NOTE: I recently removed my aic7xxx out of the motherboard, so the
> > driver obviously can't find it. But if I remove aic7xxx from the modules
> > list, this oops does _not_ happen.
> 
> That's useful infomation.  It indicates that the aic7xxx driver is screwing
> up the kobject lists.
> 
> Just to confirm: are you saying that the aic7xxx driver is loaded at the
> tie of the oops, but there is no aic7xxx hardware present in the machine?


I stumbled up this in early January.  I posted a patch to linux-scsi,
but it dosn't seem to be merged at this point.  This problem will also
occur with the aic79xx driver.

Here's the location of the original thread:
http://marc.theaimsgroup.com/?l=linux-scsi&m=107307695430108&w=2

I just tried the patch on 2.6.3, and it still applies cleanly.

Eric Kerin







