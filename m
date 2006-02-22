Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWBVPhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWBVPhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBVPhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:37:04 -0500
Received: from xenotime.net ([66.160.160.81]:57474 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751331AbWBVPhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:37:03 -0500
Date: Wed, 22 Feb 2006 07:36:58 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc4-mm1
In-Reply-To: <43FC6B8F.4060601@ums.usu.ru>
Message-ID: <Pine.LNX.4.58.0602220733500.8025@shark.he.net>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43FC6B8F.4060601@ums.usu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Alexander E. Patrakov wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> plus hotfixes
>
> Unfortunately, I lost my .config from the old kernel, so I attempted the
> following:
>
> cd scripts
> make binoffset
> cd ..
> scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config
>
> This results in:
>
> zcat: stdin: decompression OK, trailing garbage ignored
>
> Note: I have not compiled this kernel yet, so there will be probably
> another report of real issues.

argh.  That used to work.  I'll look into it later today.
Could be that some changes in -mm broke it, or maybe not.

You could try reverting some or all of these to see if
scripts/extract-ikconfig will work for you.

extract-ikconfig-use-mktemp1.patch
  extract-ikconfig: use mktemp(1)

extract-ikconfig-be-sure-binoffset-exists-before-extracting.patch
  extract-ikconfig: be sure binoffset exists before extracting

extract-ikconfig-dont-use-long-options.patch
  extract-ikconfig: don't use --long-options

-- 
~Randy
