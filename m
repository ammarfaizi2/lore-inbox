Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSCMO6S>; Wed, 13 Mar 2002 09:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310644AbSCMO6I>; Wed, 13 Mar 2002 09:58:08 -0500
Received: from chmls16.ne.ipsvc.net ([24.147.1.151]:60401 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S310637AbSCMO5u>; Wed, 13 Mar 2002 09:57:50 -0500
Date: Wed, 13 Mar 2002 09:37:20 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
        Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020313143720.GA32244@pimlott.ne.mediaone.net>
Mail-Followup-To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
	Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
	jaharkes@cs.cmu.edu,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net> <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.27i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 10:39:28AM +0100, Geert Uytterhoeven wrote:
> On Tue, 12 Mar 2002, Andrew Pimlott wrote:
> > This is misleading--Clearcase stores versions on top a normal
> > filesystem (like most other RCS's), and all manipulation is entirely
>                                                               ^^^^^^^^
> > in user-space (over the network to server processes).  There only
>   ^^^^^^^^^^^^^
> > filesystem magic is that there are directories you cannot list (plus
> > permission semantics are a little funny).
> 
> So what's that ClearCase file system driver doing in kernel space?

Just providing a convenient view on the repository.  The only write
operation you can do through the filesystem is write to the checked
out version.  Checkin, checkout, branch, label, create new
file/directory, rename, link, chmod, etc are all user-space.

Also, you can use ClearCase without the filesystem (snapshot view)
and get all the same functionality.

Andrew
