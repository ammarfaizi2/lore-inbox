Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261915AbRESRpg>; Sat, 19 May 2001 13:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbRESRp0>; Sat, 19 May 2001 13:45:26 -0400
Received: from vitelus.com ([64.81.36.147]:26117 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261905AbRESRpU>;
	Sat, 19 May 2001 13:45:20 -0400
Date: Sat, 19 May 2001 10:45:11 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Alexander Viro <viro@math.psu.edu>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010519104511.A2648@vitelus.com>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu> <20010519184819.M18853@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010519184819.M18853@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Sat, May 19, 2001 at 06:48:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 06:48:19PM +0200, Erik Mouw wrote:
> One of the fundamentals of Unix is that "everything is a file" and that
> you can do everything by reading or writing that file.

But /dev/sda/offset=234234,limit=626737537 isn't a file! ls it and see
if it's there. writing to files that aren't shown in directory listings
is plain evil. I really don't want to explain why. It's extremely
messy and unintuitive.

It would be better to do this with a file that does exist, for example
writing something to /proc/disks/sda/arguments. Then again, I don't
even think much of dynamic file systems in the first place.
