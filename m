Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRDBJgS>; Mon, 2 Apr 2001 05:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132654AbRDBJgI>; Mon, 2 Apr 2001 05:36:08 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:55004 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S132653AbRDBJfy>; Mon, 2 Apr 2001 05:35:54 -0400
Date: Mon, 2 Apr 2001 11:29:44 +0200 (CEST)
From: Matthias Welwarsky <matze@stud.fbi.fh-darmstadt.de>
To: Ollie Lho <ollie@sis.com.tw>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3-pre8 breaks trident/ALi5451 driver on Acer Travelmate
 522TX
In-Reply-To: <Pine.LNX.4.30.0103281121420.24096-100000@stud.fbi.fh-darmstadt.de>
Message-ID: <Pine.LNX.4.30.0104021121250.6246-100000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've meanwhile been digging around a bit to maybe find something obvious,
but no luck. However, I have to revise my bug report a bit: The driver is
not complete broken. Playback works OK, but there's something wrong with
the AC97 codec support. And it's not related to any of the changes made to
trident.c in 2.4.3. I tried the version of trident.c from 2.4.1, with the
same result.

Specifically, what happens is that trident.c/ali_ac97_get times out on
every call (in the outer loop), no matter what register is accessed. Any
idea what general change between 2.4.1 and 2.4.3 could cause that? It
doesn't seem to be sound related particularly..

best regards,
	Matthias

--
Two OS engineers facing a petri net chart:
	"dead lock in four moves!"

