Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269392AbRHCO45>; Fri, 3 Aug 2001 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269393AbRHCO4r>; Fri, 3 Aug 2001 10:56:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:17167 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269392AbRHCO4a>; Fri, 3 Aug 2001 10:56:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Amit S. Kale" <akale@veritas.com>, Sujal Shah <sujal@sujal.net>
Subject: Re: FS Development (or interrupting ls)
Date: Fri, 3 Aug 2001 16:43:19 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tigran@veritas.com
In-Reply-To: <3B69EF9C.74DF18D6@sujal.net> <3B6A7A72.C2BF8C26@veritas.com>
In-Reply-To: <3B6A7A72.C2BF8C26@veritas.com>
MIME-Version: 1.0
Message-Id: <01080316431904.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 12:18, Amit S. Kale wrote:
> Tigran Aivazian had a patch for doing a forced unmount.
> It will solve your problem.  You can check whether he has a patch
> for the kernel you are using.

And please post that patch to the list when you find it, or the URL :-)

--
Daniel

> Sujal Shah wrote:
> > I'm working on a userspace filesystem daemon which replaces Venus (from
> > CODA) or podfuk (UserVFS) using the CODA driver.  I'm still early in my
> > development process, but I've run into one frustrating problem.  While
> > testing my code, I have started causing ls to hang.
> >
> > It keeps the directory open, which means I can't do things like, oh,
> > unmount the filesystem. :-)  Anyone have any suggestions on recovering
> > gracefully when this happens short of rebooting (which is what I do
> > now)?  Basically, 'ls' hangs, and can't be killed (even kill -9) and
> > 'lsof' lists the directory as open (which is furthered confirmed by
> > umount complaining about the filesystem being busy).
