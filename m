Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTDOJMH (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 05:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTDOJMH (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 05:12:07 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:22937 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264410AbTDOJMG (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 05:12:06 -0400
Date: Tue, 15 Apr 2003 11:23:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jamie Lokier <jamie@shareable.org>, Paul Mackerras <paulus@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
Message-ID: <20030415092332.GE10280@wohnheim.fh-wedel.de>
References: <20030415044505.GA25139@mail.jlokier.co.uk> <Pine.GSO.4.21.0304151010240.26578-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.21.0304151010240.26578-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 April 2003 10:11:37 +0200, Geert Uytterhoeven wrote:
> 
> BTW, Atari uses MS-DOS style partitioning.

Interesting. Then how do you explain this (2.5.67)
config MSDOS_PARTITION
	bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
	default y if !PARTITION_ADVANCED && !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27

or this (2.4.20)
   if [ "$CONFIG_AMIGA" != "y" -a "$CONFIG_ATARI" != "y" -a \
        "$CONFIG_MAC" != "y" -a "$CONFIG_SGI_IP22" != "y" -a \
        "$CONFIG_SGI_IP27" != "y" ]; then
      define_bool CONFIG_MSDOS_PARTITION y
   fi

In both cases, CONFIG_MSDOS_PARTITION is always y, *except* for Atari
and some others. According to your comment above, that should be
changed, shouldn't it?

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
