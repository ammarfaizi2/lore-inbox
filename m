Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264597AbSIVXWp>; Sun, 22 Sep 2002 19:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSIVXWo>; Sun, 22 Sep 2002 19:22:44 -0400
Received: from p0052.as-l042.contactel.cz ([194.108.237.52]:4992 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S264597AbSIVXWo>;
	Sun, 22 Sep 2002 19:22:44 -0400
Date: Mon, 23 Sep 2002 01:23:04 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Peter <cogwepeter@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 ncpmount
Message-ID: <20020922232304.GC2771@ppc.vc.cvut.cz>
References: <Pine.LNX.4.44.0209221038300.21911-100000@greenie.frogspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209221038300.21911-100000@greenie.frogspace.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 10:46:31AM -0700, Peter wrote:
> 
> When I mount a Novell Netware file server on 2.4.19-ac4, I can access it
> with a file browser (konqueror, lynx), but ls gives "Stale NFS file
> handle" and other bash commands such as find fail. 2.4.16 works fine.
> 
> Cheers,
> Peter
> 
> #strace ls
> open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ESTALE (Stale 
> NFS file handle)

It should be fixed in latest 2.4.20-preX from Marcelo. VFS rules
for dentry's d_revalidate changed between 2.4.18 and 2.4.19, and I did not
notice that because of I use 2.5.x only.
							Petr Vandrovec
							vandrove@vc.cvut.cz
