Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTJNLka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJNLka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:40:30 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37793 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262433AbTJNLk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:40:26 -0400
Date: Tue, 14 Oct 2003 07:40:23 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - stability freeze
Message-ID: <20031014074023.M26086@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031013173446.GA13186@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031013173446.GA13186@suse.de>; from olh@suse.de on Mon, Oct 13, 2003 at 07:34:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 07:34:46PM +0200, Olaf Hering wrote:
>  On Wed, Oct 08, Linus Torvalds wrote:
> 
> > The more interesting thing is that I and Andrew are trying to calm down 
> > development, and I do _not_ want to see patches that don't fix a real and 
> > clear bug. In other words, the "cleanup and janitorial" stuff is on hold, 
> > and -test8 and then -test9 should be for _stability_ fixes only.
> 
> a longstanding bug, should probably go to the main Makefile. But I dont
> know if all supported archs know about -msoft-float.

It is not supported on all arches (and various lk arches already use similar
switches in their arch/<arch>/Makefile, e.g. sparc* uses -mno-fpu,
ppc* use -msoft-float, arm uses -mno-fpu -msoft-float, sh64 -m5-32media-nofpu).
So IMHO it should stay in arch/<arch>/Makefile.

	Jakub
