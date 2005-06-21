Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVFUOIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVFUOIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVFUOIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:08:23 -0400
Received: from [85.8.12.41] ([85.8.12.41]:16056 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261471AbVFUOGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:06:46 -0400
Message-ID: <42B81ED6.7040706@drzeus.cx>
Date: Tue, 21 Jun 2005 16:06:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
References: <42B7F740.6000807@drzeus.cx> <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx> <Pine.LNX.4.61.0506211451040.3728@scrub.home> <42B80F40.8000609@drzeus.cx> <Pine.LNX.4.61.0506211515210.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506211515210.3728@scrub.home>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>
>No, go through the warnings, analyze each one and choose an appropriate 
>solution. You might want to keep notes, which you can post with the 
>changelogs, so one can reproduce, why a certain change was done.
>
>  
>

The problem is that they're mostly calls to library functions (strlen,
strcmp, fgets, etc.) so it's either the solaris way or the glibc way.

A (somewhat unclean) solution is to make the type change based on the
platform. Are there any defines present to test if we're in a Solaris
environment? I don't have access to any Solaris machines myself so I
can't really test.

Rgds
Pierre

