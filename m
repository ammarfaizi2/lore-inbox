Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270255AbRHHBNH>; Tue, 7 Aug 2001 21:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270256AbRHHBM6>; Tue, 7 Aug 2001 21:12:58 -0400
Received: from zok.SGI.COM ([204.94.215.101]:4298 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270255AbRHHBMs>;
	Tue, 7 Aug 2001 21:12:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: using mount from SUID scripts? 
In-Reply-To: Your message of "Tue, 07 Aug 2001 16:29:39 MST."
             <20010807162939.A26249@one-eyed-alien.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Aug 2001 11:12:53 +1000
Message-ID: <27034.997233173@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001 16:29:39 -0700, 
Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
>I've got an SUID perl script (yes, it's EUID is really 0) which I'd like to
>use mount from to mount a file via loopback...
>
>Unfortunately, it looks like mount refuses to actually mount anything if
>the EUID and UID aren't the same....

Are you sure the problem is mount?  Some versions of bash drop euid(0)
when they execute scripts from setuid programs.

