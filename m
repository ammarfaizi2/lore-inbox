Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTHLTcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTHLTcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 15:32:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:129 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S269736AbTHLTcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 15:32:47 -0400
Date: Tue, 12 Aug 2003 20:43:57 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308121943.h7CJhvsa000910@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, miller@techsource.com
Subject: Re: [2.6 patch] add an -Os config option
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>+config OPTIMIZE_FOR_SIZE
> >>+	bool "Optimize for size" if EMBEDDED
> >>+	default n
> >>+	help
> >>+	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> >>+	  resulting in a smaller kernel.
> >>+
> >>+	  The resulting kernel might be significantly slower.
> > 
> > 
> > With most of the gcc's I tried -Os was faster.
>
>
> Why is -Os faster?  Fewer cache misses?
>
> Wouldn't that make -O2 kinda pointless?  It seems kinda futile to 
> optimize for speed just to have it come out slower.

See the comments Linus made earlier this year on the same subject:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104457390406050&w=2

Alan, could Valgrind help us to profile cache hits/misses in different
parts of the kernel?

John.
