Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSGIPux>; Tue, 9 Jul 2002 11:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSGIPuw>; Tue, 9 Jul 2002 11:50:52 -0400
Received: from ns.suse.de ([213.95.15.193]:61196 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315481AbSGIPuw>;
	Tue, 9 Jul 2002 11:50:52 -0400
Date: Tue, 9 Jul 2002 17:53:34 +0200
From: Dave Jones <davej@suse.de>
To: "Scott M. Hoffman" <scott783@attbi.com>
Cc: Duncan Sands <duncan.sands@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.25-dj1
Message-ID: <20020709175334.H1697@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Scott M. Hoffman" <scott783@attbi.com>,
	Duncan Sands <duncan.sands@wanadoo.fr>, linux-kernel@vger.kernel.org
References: <200207091140.42367.duncan.sands@wanadoo.fr> <Pine.LNX.4.44.0207091026270.14288-100000@ScottnBonnies.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207091026270.14288-100000@ScottnBonnies.attbi.com>; from scott783@attbi.com on Tue, Jul 09, 2002 at 10:29:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:29:59AM -0500, Scott M. Hoffman wrote:

 > > fs/fs.o: In function `proc_pid_stat':
 > > fs/fs.o(.text+0x1fb72): undefined reference to `__udivdi3'
 > > fs/fs.o: In function `kstat_read_proc':
 > > fs/fs.o(.text+0x20b42): undefined reference to `__udivdi3'
 > > fs/fs.o(.text+0x20bd0): undefined reference to `__udivdi3'
 > I'm also getting this error.  Looking it up on Google points to earlier 
 > problems than 2.5.25, both with binutils and gcc.  I've tried binutils 
 > 2.11, 2.12 and gcc 2.95.3, 2.96(RH 7.3), and 3.1.  No combination seems 
 > to work.

It's a clash with the jiffies_to_clock_t stuff that went into 2.5.25,
and the >497 day uptime wrap fix that went into my tree. 
I'll put up a -dj2 later today fixing this.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
