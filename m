Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLGODL>; Thu, 7 Dec 2000 09:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLGODB>; Thu, 7 Dec 2000 09:03:01 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:57618 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129370AbQLGOCv>; Thu, 7 Dec 2000 09:02:51 -0500
Date: Thu, 7 Dec 2000 15:44:54 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.21.0012071248480.970-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012071525540.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> > Reserved fd's for superuser doesn't work.
> It does actually work,

What do you mean under "work"? I meant user apps are able to
exhaust fd's completely and none is left for superuser.

> but remember that the concept of "reserved file
> structures for superuser" is defined as "file structures to be taken from
> the freelist"

Yes, in this sense it works and it's also very close to unhelpfulness.

> whereas your patch below:
[...]
> allows one to allocate a file structure from the filp_cache slab cache if
> one is a superuser.

Or one is user and didn't hit yet the reserved fd's (and of course
superuser aren't able to allocate more then max_files).

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
