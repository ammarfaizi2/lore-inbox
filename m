Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTATA45>; Sun, 19 Jan 2003 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbTATA45>; Sun, 19 Jan 2003 19:56:57 -0500
Received: from tsv.sws.net.au ([203.36.46.2]:7174 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S267726AbTATA4t>;
	Sun, 19 Jan 2003 19:56:49 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCH] Add LSM sysctl hook to 2.5.59
Date: Mon, 20 Jan 2003 02:05:41 +0100
User-Agent: KMail/1.5
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
References: <200301172154.QAA00757@moss-shockers.ncsc.mil> <200301200139.39092.russell@coker.com.au> <20030120004320.A10659@infradead.org>
In-Reply-To: <20030120004320.A10659@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301200205.41049.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 01:43, Christoph Hellwig wrote:
> On Mon, Jan 20, 2003 at 01:39:39AM +0100, Russell Coker wrote:
> > > What's the reason you can't just live with DAC for sysctls?
> >
> > What exactly do you mean by "live with DAC" in this context?  If you mean
> > "allow UID==0 processes to do whatever they like" then it's not going to
> > work for any sort of chroot setup.
>
> This means check the unix file permissions / ACLs only overriden by
> CAP_FOWNER processes.

I don't think that would do for my chroot environments.  I want to have root 
owned processes running in a chroot with no ability to escape or to affect 
the outside environment (and proc is mounted in the chroot).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

