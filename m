Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVGTOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVGTOop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGTOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:44:44 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:65102 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261272AbVGTOoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:44:22 -0400
Date: Wed, 20 Jul 2005 16:44:21 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
Message-ID: <20050720144421.GK7050@harddisk-recovery.com>
References: <200507201416.36155.naber@inl.nl> <20050720132006.GI7050@harddisk-recovery.com> <dbljub$mgm$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbljub$mgm$1@news.cistron.nl>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 01:35:07PM +0000, Miquel van Smoorenburg wrote:
> In article <20050720132006.GI7050@harddisk-recovery.com>,
> Erik Mouw  <erik@harddisk-recovery.com> wrote:
> >On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
> >AFAIK you can't use a 15 GB tmpfs on i386 because large memory support
> >is basically a hack to support multiple 4GB memory spaces (some VM guru
> >correct me if I'm wrong).
> 
> I'm no VM guru but I have a 32 bit machine here with 8 GB of
> memory and 8 GB of swap:
> 
> # mount -t tmpfs -o size=$((12*1024*1024*1024)) tmpfs /mnt
> # df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda1             19228276   1200132  17051396   7% /
> tmpfs                 12582912         0  12582912   0% /mnt
> 
> There you go, a 12 GB tmpfs. I haven't tried to create a 12 GB
> file on it, though, since this is a production machine and it
> needs the memory ..

I stand corrected.

> So yes that appears to work just fine.

The question is if it's a good idea to use a 15GB tmpfs on a 32 bit
i386 class machine. I guess a real 64 bit machine will be much faster
in handling suchs amounts of data simply because you don't have to go
through the hurdles needed to address such memory on i386.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
