Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSEDT7u>; Sat, 4 May 2002 15:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315209AbSEDT7t>; Sat, 4 May 2002 15:59:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50174 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315207AbSEDT7s>;
	Sat, 4 May 2002 15:59:48 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 May 2002 21:59:26 +0200 (MEST)
Message-Id: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: IO stats in /proc/partitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I noticed that RedHat did put some statistics in
/proc/partitions. That was bad, but I assumed that it was
their laziness, being too busy to do a proper job.

However, I see that these days the pollution of /proc/partitions
is becoming official - it is part of patch-2.4.19-pre7.
I strongly object, and hope it is not too late to revert this.

Things must do one thing, and one thing well.
The task of /proc/partitions is to list which partitions the
kernel knows about. When I implemented it I thought that adding
the starting offset would be superfluous, but in fact I now realize
that that is required for several applications.
So, /proc/partitions must be updated sooner or later with an
additional field "starting offset". Possibly more fields to
enable identification. Sometimes it is really difficult to
determine which Linux name belongs to which hardware device,
especially with USB.

On the other hand, disk statistics should not be in
/proc/partitions. They should be in /proc/diskstatistics.
I see a heading today "rio rmerge rsect ruse wio wmerge"
"wsect wuse running use aveq". No doubt next year we'll
want different statistics. So /proc/diskstatistics should
start with a header line including a version field.

Please keep these disk statistics apart from /proc/partitions.

Andries
