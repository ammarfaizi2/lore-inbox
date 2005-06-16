Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVFPLhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVFPLhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVFPLhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:37:04 -0400
Received: from quechua.inka.de ([193.197.184.2]:21401 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261580AbVFPLgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:36:45 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200506152144.56540.pmcfarland@downeast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Disfr-0005KJ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 16 Jun 2005 13:36:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200506152144.56540.pmcfarland@downeast.net> you wrote:
> Bingo. Only the operating system itself and software displaying filenames 
> needs to understand Unicode; the file system implementation itself just knows 
> its a string of bytes and nothing else.

The filesystem needs to understand and translate the path names, if the
Filesystem specification mandates a different encoding for file names (for
example UTF-16). Thats why you fequently see translations in legacy
filesystems which have national encoding in the on-disk format (think FAT)

And if the filesystem uses unicode, you also need to enforce the naming of
files in UTF-8 to do reliable translation. Currently user mode may also send
you non-UTF8 national chars.

Bernd
