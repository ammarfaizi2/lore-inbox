Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSE1XSo>; Tue, 28 May 2002 19:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313038AbSE1XSn>; Tue, 28 May 2002 19:18:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62191 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312973AbSE1XSn>; Tue, 28 May 2002 19:18:43 -0400
Subject: Re: wait queue process state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020528190518.E21009@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 01:21:47 +0100
Message-Id: <1022631707.4123.151.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 00:05, Benjamin LaHaise wrote:
> On Tue, May 28, 2002 at 04:01:43PM -0700, jw schultz wrote:
> > The read system call is interuptable, period.  Disk access
> > is considered slow.   If you code asuming it will not be
> > interupted or that an interupt will cause a return of -1
> > your code may break on Linux and will certainly not be
> > portable.
> 
> Linux does not permit interrupting regular file reads on local disks; 
> only NFS supports it.  Maybe 2.5 is the time to change this.

What Unix and standards say and do make that one unfortunately a very
bad idea. Its true that to the letter of the specs you can do
interruptible disk I/O. Its also true to the real world that vast
amounts of software breaks in subtle, unreported, oh hell what ate my
file kind of ways

