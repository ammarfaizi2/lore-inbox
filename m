Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTASO5V>; Sun, 19 Jan 2003 09:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267477AbTASO5V>; Sun, 19 Jan 2003 09:57:21 -0500
Received: from urtica.linuxnews.pl ([217.67.200.130]:16146 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S267474AbTASO5U>; Sun, 19 Jan 2003 09:57:20 -0500
Date: Sun, 19 Jan 2003 16:05:50 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Joshua Kwan <joshk@ludicrus.ath.cx>
cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
In-Reply-To: <20030119091043.GA8856@ludicrus.ath.cx>
Message-ID: <Pine.LNX.4.33.0301191600180.16178-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003, Joshua Kwan wrote:

Josh,

> How stable would you say NTFS write is for this release? Is it as
> yucky as it was in the 2.4.20 driver version?

Ntfsprogs is a library and set of utilities to do variuos things with the
ntfs filesystem. It is not the kernel driver.

And the kernel driver is what you give the write ability to the ntfs
filesystem. And you are right -- the old driver in fact does not support
writing (yeah, DANGEROUS means your filesystem will get damaged with very
high probability).

There exists a new ntfs driver called NTFS-TNG, which is present already
in 2.5.x kernel series and it has its backport to the 2.4.x kernel series
(you'll find it at http://linux-ntfs.sf.net/).

This driver has no write support yet, but it allows you to overwrite the
files, without changing their attributes and size (ie. mmap() the file,
change the contents, write() the file). And the overwrite is considered
safe.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

