Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRJKGRC>; Thu, 11 Oct 2001 02:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJKGQn>; Thu, 11 Oct 2001 02:16:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38085 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272593AbRJKGQh>;
	Thu, 11 Oct 2001 02:16:37 -0400
Date: Thu, 11 Oct 2001 02:17:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: arvest@orphansonfire.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <20011011000814.B23927@turbolinux.com>
Message-ID: <Pine.GSO.4.21.0110110211340.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Andreas Dilger wrote:

> You probably need to go into fdisk and change the partition type of
> sda9 from "0" to "83" (or any other non-zero type).  There is a
> reason that it is saying "omitting empty partition (9)" at boot,
> and "fdisk -l" doesn't list it - because type "0" means "I don't exist".
> 
> In fdisk, use the "t" option to set the type of sda9.

... and after that try to boot into 2.4.11 again.  It might be a
corruption introduced by partition code changes.  What I don't
understand is how the hell does 2.4.10 manage to mount it if
it hadn't registered the sucker...

