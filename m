Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbRHARIS>; Wed, 1 Aug 2001 13:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbRHARII>; Wed, 1 Aug 2001 13:08:08 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:6478 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267633AbRHARH6>; Wed, 1 Aug 2001 13:07:58 -0400
Date: Wed, 1 Aug 2001 17:39:51 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3-users@redhat.com
Cc: Sean Hunter <sean@uncarved.com>, linux-kernel@vger.kernel.org
Subject: Re: Strane remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010801173951.I3744@redhat.com>
In-Reply-To: <20010727104049.B6311@uncarved.com> <200107271715.f6RHFea24226@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107271715.f6RHFea24226@lynx.adilger.int>; from adilger@turbolinux.com on Fri, Jul 27, 2001 at 11:15:39AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 27, 2001 at 11:15:39AM -0600, Andreas Dilger wrote:

> > servers.  Since the server in question is a farily security-sensitive box, my
> > /usr partition is mounted read only except when I remount rw to install
> > packages.
> 
> If it is a security-sensitive box, you need to at least use data=ordered or
> data=journal.  Using data=writeback allows the possibility that after a crash
> one user might be able to read data from deleted files of another user (note
> that reiserfs currently only runs the equivalent of data=writeback).

Agreed, and for most workloads data=ordered will have very little
performance difference from data=writeback.

> You _could_ leave out the data=writeback from /etc/fstab (default is ordered),
> and you will be able to remount OK.  Also, Andrew made a patch which allowed
> you to specify the data= mode on remount, as long it is the same. 

Indeed, but I'll need to make sure that the remount with no data= mode
also works (that should be legal.)

Cheers,
 Stephen
