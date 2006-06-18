Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWFRTW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWFRTW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFRTW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:22:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932294AbWFRTW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:22:28 -0400
Date: Sun, 18 Jun 2006 12:22:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Implement AT_SYMLINK_FOLLOW flag for linkat
In-Reply-To: <20060618191629.GE27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606181220590.5498@g5.osdl.org>
References: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com>
 <20060618191629.GE27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Jun 2006, Al Viro wrote:
> 
> Where does POSIX require that?  IIRC, it was along the lines of "application
> can't rely on kernel doing the right thing", not "kernel must do the
> wrong thing"...

Well, the patch as sent in does seem sane, as long as glibc doesn't start 
defaulting to the insane behaviour. Giving users the _ability_ to link to 
the symlink target is certainly not wrong, regardless of any standard. 
Doing it by default is another matter.

		Linus
