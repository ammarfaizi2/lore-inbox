Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132491AbRCZRTN>; Mon, 26 Mar 2001 12:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRCZRTE>; Mon, 26 Mar 2001 12:19:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132489AbRCZRSr>;
	Mon, 26 Mar 2001 12:18:47 -0500
Date: Mon, 26 Mar 2001 18:18:03 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3ABF70B9.573C2F85@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABF70B9.573C2F85@sgi.com>; from law@sgi.com on Mon, Mar 26, 2001 at 08:39:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 08:39:21AM -0800, LA Walsh wrote:
> I vaguely remember a discussion about this a few months back.
> If I remember, the reasoning was it would unnecessarily slow
> down smaller systems that would never have block devices in
> the 4-28T range attached.  

4k page size * 2GB = 8TB.

i consider it much more likely on such systems that the page size will
be increased to maybe 16 or 64k which would give us 32TB or 128TB.
you keep on trying to increase the size of types without looking at
what gcc outputs in the way of code that manipulates 64-bit types.
seriously, why don't you just try it?  see what the performance is.
see what the code size is.  then come back with some numbers.  and i mean
numbers, not `it doesn't feel any slower'.

personally, i'm going to see what the situation looks like in 5 years time
and try to solve the problem then.  there're enough real problems with the
VFS today that i don't feel inclined to fix tomorrow's potential problems.

-- 
Revolutions do not require corporate support.
