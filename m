Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRKVRPJ>; Thu, 22 Nov 2001 12:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280101AbRKVRO7>; Thu, 22 Nov 2001 12:14:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280095AbRKVROu>; Thu, 22 Nov 2001 12:14:50 -0500
Date: Thu, 22 Nov 2001 09:09:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Erik Andersen <andersen@codepoet.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix SCSI non-blocksize reads
In-Reply-To: <20011122014131.A16981@codepoet.org>
Message-ID: <Pine.LNX.4.33.0111220908010.1383-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Erik Andersen wrote:
>
> Several SCSI drivers blindly do reads of size 1024 when trying to read
> the partition table.   This fails on Magneto Optical drives and similar
> odd devices with 2048 byte native sector sizes.  This patch fixes that
> so I can have partitions on my MO drive again (it lives on an Adaptec
> card at present and has 2048 byte sectors),

Please use the "block_size()" function instead of doing it by hand..

		Linus

