Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbREVVgh>; Tue, 22 May 2001 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262847AbREVVg1>; Tue, 22 May 2001 17:36:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7343 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262843AbREVVgT>;
	Tue, 22 May 2001 17:36:19 -0400
Date: Tue, 22 May 2001 23:35:42 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105222135.XAA78936.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] struct char_device
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:

> I fully agree with you.

Good.

Unfortunately I do not fully agree with you.

> Most of the places where there kernel is passing kdev_t
> would be entierly satisfied with only the knowlendge of
> the minor number.

My kdev_t is a pointer to a structure with device data
and device operations. Among the operations a routine
that produces a name. Among the data, in the case of a
block device, the size, and the sectorsize, ..

A minor gives no name, and no data.

Linus' minor is 20-bit if I recall correctly.
My minor is 32-bit. Neither of the two can be
used to index arrays.

Andries
