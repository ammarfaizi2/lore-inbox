Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313679AbSDPNyS>; Tue, 16 Apr 2002 09:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313681AbSDPNyR>; Tue, 16 Apr 2002 09:54:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63227 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313679AbSDPNyR>;
	Tue, 16 Apr 2002 09:54:17 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 16 Apr 2002 15:54:15 +0200 (MEST)
Message-Id: <UTC200204161354.g3GDsFO28323.aeb@smtp.cwi.nl>
To: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: readahead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[readahead.c has badly readable comments, on a standard
80-column display: many lines have a size just slightly
over 80 chars]

In the good old days we had tunable readahead.
Very good, especially for special purposes.

I recall the days where I tried to get something off
a bad SCSI disk, and the kernel would die in the retries
trying to read a bad block, while the data I needed was
not in the block but just before. Set readahead to zero
and all was fine.

Yesterday evening I was playing with my sddr09 driver,
reading SmartMedia cards, and found to my dismay that
the kernel wants to do a 128 block readahead.
Not only is that bad on a slow medium, one is waiting
a noticeable time for unwanted data, but it is worse
that setting the readahead no longer works.

[Indeed, it is very desirable to be able to set readahead
to zero. It is also desirable to be able to set it to a
small value. Today on 2.5.8 both are impossible, readahead.c
insists on a minimum readahead of 16 sectors.]

Andries
