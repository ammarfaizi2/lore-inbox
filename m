Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTALWtA>; Sun, 12 Jan 2003 17:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTALWtA>; Sun, 12 Jan 2003 17:49:00 -0500
Received: from almesberger.net ([63.105.73.239]:19718 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267617AbTALWs6>; Sun, 12 Jan 2003 17:48:58 -0500
Date: Sun, 12 Jan 2003 19:57:41 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Manish Lachwani <m_lachwani@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using lilo to boot off any drive ...
Message-ID: <20030112195741.B6866@almesberger.net>
References: <20030110210035.76482.qmail@web20502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110210035.76482.qmail@web20502.mail.yahoo.com>; from m_lachwani@yahoo.com on Fri, Jan 10, 2003 at 01:00:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Lachwani wrote:
> When the control is transferred to lilo on sda (sdb
> actually), is there a way for me to boot off sdd now
> (which was previously sde)? I mean, is there any way
> that lilo can load the appropriate kernel image?

You could have two independent installations of LILO, one on
sda, and one on sdb, where the latter accesses no files from
sda and defines the disk numbers (for the BIOS) the way they
look when sda is removed.

Then, you probably want to rename /sbin/lilo to /sbin/lilo.bin
or such, and write a script /sbin/lilo that generates the
modified lilo.conf files, and updates both instances of LILO.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
