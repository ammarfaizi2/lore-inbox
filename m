Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSE1XFT>; Tue, 28 May 2002 19:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSE1XFS>; Tue, 28 May 2002 19:05:18 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:58362 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S311752AbSE1XFR>; Tue, 28 May 2002 19:05:17 -0400
Date: Tue, 28 May 2002 19:05:18 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state
Message-ID: <20020528190518.E21009@redhat.com>
In-Reply-To: <3CF2A0FB.8090507@um.edu.mt> <1022572663.12203.127.camel@pc-16.office.scali.no> <20020528160143.G885@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 04:01:43PM -0700, jw schultz wrote:
> The read system call is interuptable, period.  Disk access
> is considered slow.   If you code asuming it will not be
> interupted or that an interupt will cause a return of -1
> your code may break on Linux and will certainly not be
> portable.

Linux does not permit interrupting regular file reads on local disks; 
only NFS supports it.  Maybe 2.5 is the time to change this.

		-ben
