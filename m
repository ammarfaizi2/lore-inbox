Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbTLIMyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 07:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbTLIMyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 07:54:23 -0500
Received: from stingr.net ([212.193.32.15]:31184 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S265567AbTLIMyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:54:18 -0500
Date: Tue, 9 Dec 2003 15:54:14 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209125414.GQ30105@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200312081536.26022.andrew@walrond.org> <200312081559.04771.andrew@walrond.org> <20031208233840.GD31370@kroah.com> <200312091037.20770.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200312091037.20770.andrew@walrond.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Andrew Walrond:
> My initial query has thrown up lots of interesting debate :)
> 
> I, like most people I suspect, love the concept of a complete auto-populated 
> dev directory, and not having to MAKEDEV.
> 
> devfs provided this, but like most people who read LKML, I stopped using it 
> when it's problems were discussed.
> 
> I really hope udev lives up to its promise, unlike devfs. Manually creating /
> dev just annoys me for no apparent reason other than it's plain inelegance I 
> suppose.

The one of main benefits I considered when focusing my attention on
devfs-like approach is space consumption. Somewhat-populated dev
subdirectory (looking at fedora 1) have about 7k items inside, each of
them eating its inode and (depends on underlying fs) a block.

I agree that previous implementation may be racy, domb, gooched,
whatever.
but
is it sane that for system to function correcly I should carry over
a whole bunch of directory entries, when I actually have all
information about it in kernel, somewhere buried under major-minor
declarations. 

That is, udev backed on tmpfs approach are almost
solving our problem. But not completely. Module autoloading is useful,
actually, was useful in conjunction with module unloading - if
unloading support is poor autoloading is almost useless ...

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
