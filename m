Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282880AbRLQVOy>; Mon, 17 Dec 2001 16:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRLQVOp>; Mon, 17 Dec 2001 16:14:45 -0500
Received: from marine.sonic.net ([208.201.224.37]:22305 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S282880AbRLQVOe>;
	Mon, 17 Dec 2001 16:14:34 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 17 Dec 2001 13:14:29 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk size clarification
Message-ID: <20011217211429.GA8826@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C1E587C.9060300@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1E587C.9060300@antefacto.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 08:41:32PM +0000, Padraig Brady wrote:
> and also there is no upper limit on the amount of RAM used,
> so the following will kill your system (well it did for me):
> dd if=/dev/zero of=/dev/ram0

Bug in recent 2.4.*.  It *should* stop.  One line patch has been
posted to the linux-kernel list a couple of times.  Check the archive.
It's probably in the recent pre-release kernels as well.

As a work around, try the following:

count=`blockdev --getsize /dev/ram0`
bsize=`blockdev --getss /dev/ram0`
dd if=/dev/zero of=/dev/ram0 count=${count} bs=${bsize}

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
