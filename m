Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269877AbRHEA2t>; Sat, 4 Aug 2001 20:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269879AbRHEA2j>; Sat, 4 Aug 2001 20:28:39 -0400
Received: from marine.sonic.net ([208.201.224.37]:58998 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S269877AbRHEA2d>;
	Sat, 4 Aug 2001 20:28:33 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sat, 4 Aug 2001 17:28:40 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@math.psu.edu>
Subject: Re: fdatasync(2) is also there (was: intermediate summary of ext3-2.4-0.9.4 thread)
Message-ID: <20010804172840.L437@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010804054043.F16516@emma1.emma.line.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 05:40:43AM +0200, Matthias Andree wrote:
> How portable is fsync()ing the directory?

It is as portable as assuming that the directory entries are synced during
fsync().

> 
> How USEFUL is it to the application if all other boxen fsync() the
> directory entries along with the file?

Except, you can NOT guarantee that this is the case.  The spec does NOT
require it.

> You want to sync the files, but the directory only after you created all
> of the files? Use fdatasync(2) for the files - it doesn't flush meta
> data, then sync the directory. It's POSIX, it's SUS v2.

Is fsync(dir) what you mean here?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
