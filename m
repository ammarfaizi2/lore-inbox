Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVIXHoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVIXHoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 03:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVIXHoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 03:44:18 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:39946 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932146AbVIXHoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 03:44:17 -0400
To: viro@ftp.linux.org.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050924070150.GL7992@ftp.linux.org.uk> (message from Al Viro on
	Sat, 24 Sep 2005 08:01:50 +0100)
Subject: Re: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
References: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu> <20050923122834.659966c4.akpm@osdl.org> <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu> <20050924060913.GK7992@ftp.linux.org.uk> <E1EJ3ib-0007V7-00@dorka.pomaz.szeredi.hu> <20050924070150.GL7992@ftp.linux.org.uk>
Message-Id: <E1EJ4hH-0007Yb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 24 Sep 2005 09:43:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Well yes.  But I don't think anybody is using it, and if so they are
> > > > clearly breaking the rules in man open(2):
> > > 
> > > Be liberal in what you accept and all such...  Everything else aside,
> > > why bother?
> > 
> > To conform to well defined semantics?
> 
> Well-defined is not exactly the word I'd use for that mess (example -
> we still have the last remnant of ancient BSD idiocy in there; the last
> case when dangling symlink is still traversed upon object creation,
> everything else had been fixed since then).
> 
> And O_DIRECTORY is not the only flag that acquires or loses meaning
> depending on O_CREAT - consider e.g. O_EXCL.  It's a mess, of course,
> but this mess is part of userland ABI.  We tried to fix symlink idiocy,
> BTW, on the assumption that nothing would be relying on it.  Didn't
> work...

OK, I'm convinced.

Miklos
