Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317806AbSGPIMv>; Tue, 16 Jul 2002 04:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317812AbSGPIMu>; Tue, 16 Jul 2002 04:12:50 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:20946 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317806AbSGPIMt>; Tue, 16 Jul 2002 04:12:49 -0400
Date: Tue, 16 Jul 2002 10:15:31 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Sam Vilain <sam@vilain.net>
Cc: dax@gurulabs.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716081531.GD7955@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Sam Vilain <sam@vilain.net>, dax@gurulabs.com,
	linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17U9x9-0001Dc-00@hofmann>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 06:48:05PM +0100, Sam Vilain wrote:

> On the flipside, ext2 over reiserfs:
[...]
>   - there is a `dump' command (but it's useless, because it hangs when you
>     run it on mounted filesystems - come on, who REALLY unmounts their
>     filesystems for a nightly dump?  You need a 3 way mirror to do it
>     while guaranteeing filesystem availability...)

dump(8) doesn't hang when dumping mounted filesystems. You are refering
to a genuine bug which was fixed some time ago.

However, in some rare occasions, dump can save corrupted data when
saving a mounted and generaly highly active filesystem. Even then,
in 99% of the cases it doesn't really matter because the corrupted
files will get saved by the next incremental dump.

Come on, who REALLY expects to have consistent backups without
either unmounting the filesystem or using some snapshot techniques ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
