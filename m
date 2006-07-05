Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWGETeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWGETeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWGETeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:34:09 -0400
Received: from pat.uio.no ([129.240.10.4]:50912 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965003AbWGETeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:34:07 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060705125956.GA529@fieldses.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 15:33:53 -0400
Message-Id: <1152128033.22345.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.665, required 12,
	autolearn=disabled, AWL 1.33, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 08:59 -0400, J. Bruce Fields wrote:
> On Wed, Jul 05, 2006 at 08:24:29AM -0400, Bill Davidsen wrote:
> > Theodore Tso wrote:
> > >Some of the ideas which have been tossed about include:
> > >
> > >	* nanosecond timestamps, and support for time beyond the 2038
> > 
> > The 2nd one is probably more urgent than the first. I can see a general 
> > benefit from timestamp in ms, beyond that seems to be a specialty 
> > requirement best provided at the application level rather than the bits 
> > of a trillion inodes which need no such thing.
> 
> What's urgently needed for NFS (and I suspect for most other
> applications demanding higher timestamps) isn't really nanosecond
> precision so much as something that's guaranteed to increase whenever
> the file changes.

NFS doesn't necessarily require monotonicity either. The only real
requirement that knfsd has is that the timestamp needs to change every
time the file data (mtime+ctime) and/or metadata (ctime only) is
changed.

Applications like 'make' OTOH, probably would be happier if the
timestamps are guaranteed to be monotonic.

Cheers,
  Trond

