Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315177AbSDWMBc>; Tue, 23 Apr 2002 08:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSDWMBb>; Tue, 23 Apr 2002 08:01:31 -0400
Received: from imladris.infradead.org ([194.205.184.45]:60164 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315177AbSDWMBa>; Tue, 23 Apr 2002 08:01:30 -0400
Date: Tue, 23 Apr 2002 13:01:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_RAMFS in 2.4.19-pre7-ac2 ???
Message-ID: <20020423130111.A14849@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <aa1p5d$qki$1@cesium.transmeta.com> <Pine.LNX.4.44.0204231341480.10981-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 01:43:23PM +0200, Roy Sigurd Karlsbakk wrote:
> > CONFIG_RAMFS is probably going away, but that doesn't mean ramfs is
> > going away.  At least in Linux 2.5 ramfs will end up being required
> > core code.
> 
> According to what I was told by a guy at #KernelNewbies, CONFIG_RAMFS 
> isn't there in (menu|x)?config after -pre7, but in by default. problem is 
> - it doesn't work

fs/Config.in (2.4.19-pre7):
define_bool CONFIG_RAMFS y

[root@sb root]# uname -a
Linux sb.bsdonline.org 2.4.19-pre7-rmap13 #1 SMP Mon Apr 22 22:04:13 CEST 2002 i686 unknown
[root@sb root]# mount -tramfs none /mnt/
[root@sb root]# cp ~/mcslock.h /mnt/
[root@sb root]# ls -l /mnt/
total 0
-rw-r--r--    1 root     root         1275 Apr 23 14:58 mcslock.h
[root@sb root]#
