Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbTJGVi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJGVi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:38:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:29633 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262909AbTJGViZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:38:25 -0400
Date: Tue, 7 Oct 2003 14:37:58 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Message-ID: <20031007213758.GB3095@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com> <200310072347.41749.insecure@mail.od.ua> <20031007205244.GA2978@kroah.com> <yw1xvfr0wxfa.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xvfr0wxfa.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 11:27:37PM +0200, Måns Rullgård wrote:
> Greg KH <greg@kroah.com> writes:
> 
> >> > > What am I supposed to do, starting to use mknod again? Uggggh...
> >> >
> >> > Provide me with a kernel name to devfs name mapping file so that I can
> >> > create a "devfs like" udev config file for people who happen to like
> >> > that naming scheme.
> >> 
> >> It seems that we have a bit of misunderstanding here.
> >> 
> >> I just don't want to go back to /dev being actually placed on
> >> real, on-disk fs.
> >> 
> >> I won't mind if naming scheme will change as long
> >> as device names start with '/dev/' and appear
> >> there (semi-)automagically. That's what I call devfs.
> >> If udev can do this, I am all for that.
> >
> > udev can do this.  Is there some documentation that you read that has
> > suggested otherwise?
> 
> It's been my understanding that udev creates device nodes in a regular
> filesystem.  If this is the case, things like unclean reboots will
> leave stale files behind.  It will also not be easy to
> bootstrap. Correct me if am wrong.

mount -t ramfs none /dev

That is what udev will run off of :)

Again, can you point me to any documentation that states that udev will
do this on a persistant filesystem?

thanks,

greg k-h
