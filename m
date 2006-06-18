Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWFRTcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWFRTcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWFRTcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:32:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19361 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932306AbWFRTcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:32:22 -0400
Date: Sun, 18 Jun 2006 20:32:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Implement AT_SYMLINK_FOLLOW flag for linkat
Message-ID: <20060618193219.GF27946@ftp.linux.org.uk>
References: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com> <20060618191629.GE27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606181220590.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606181220590.5498@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 12:22:14PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 18 Jun 2006, Al Viro wrote:
> > 
> > Where does POSIX require that?  IIRC, it was along the lines of "application
> > can't rely on kernel doing the right thing", not "kernel must do the
> > wrong thing"...
> 
> Well, the patch as sent in does seem sane, as long as glibc doesn't start 
> defaulting to the insane behaviour. Giving users the _ability_ to link to 
> the symlink target is certainly not wrong, regardless of any standard. 
> Doing it by default is another matter.

As long as it doesn't get tied to overloaded environment variable that
might be needed for other purposes...
