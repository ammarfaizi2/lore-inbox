Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXK25>; Wed, 24 Jan 2001 05:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRAXK2r>; Wed, 24 Jan 2001 05:28:47 -0500
Received: from hera.cwi.nl ([192.16.191.1]:17092 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129401AbRAXK2m>;
	Wed, 24 Jan 2001 05:28:42 -0500
Date: Wed, 24 Jan 2001 11:28:28 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101241028.LAA57460.aeb@ark.cwi.nl>
To: adilger@turbolinux.com, yakker@alacritech.com
Subject: Re: Partition IDs in the New World TM
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> It would already be possible to auto-enable any devices with the swap
> signature by doing the same sort of search mount(8) is doing for LABEL
> and UUID.

That would be a very poor idea.
Since different filesystems have signatures in different places,
a partition may well have signatures for several filesystem types.
Similarly, many filesystems leave the first sector alone -
there may be some boot loader there - so if such a filesystem
was created on what used to be a swap partition, also the swap
signature will still be there.

More generally it is a bad idea to start a guessing game.
That leads to systems that usually work, instead of systems that work.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
