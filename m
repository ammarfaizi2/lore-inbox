Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWAYS7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWAYS7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWAYS7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:59:07 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:10976 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932116AbWAYS7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:59:06 -0500
Message-ID: <43D7CA7F.4010502@namesys.com>
Date: Wed, 25 Jan 2006 10:59:11 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Shishkin <edward@namesys.com>
CC: LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4, unixfile)
 vs (reiser4,cryptcompress)
References: <43D7C6BE.1010804@namesys.com>
In-Reply-To: <43D7C6BE.1010804@namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notice how CPU speed (and number of cpus) completely determines
compression performance.

cryptcompress refers to the reiser4 compression plugin, (unix file)
refers to the reiser4 non-compressing plugin.

Edward Shishkin wrote:

> Here are the tests that vs asked for:
> Creation (dd) of 20 tarfiles (the original 200M file is in ramfs)
> Kernel: 2.6.15-mm4 + current git snapshot of reiser4
>
> ------------------------------------------
>
> Laputa workstation
> Uni Intel Pentium 4 (2.26 GHz) 512M RAM
>
> ext2:
> real 2m, 15s
> sys 0m, 14s
>
> reiser4(unix file)
> real 2m, 7s
> sys  0m, 23s
>
> reiser4(cryptcompress, lzo1, 64K)
> real 2m, 13s
> sys 0m, 11s
> ------------------------------------------
>
> Belka workstation
> Dual Intel Xeon (2.4GHz) 1G RAM
>
> ext2:
> real 2m, 16s
> sys 0m, 10s
>
> reiser4(unix file)
> real 2m, 14s
> sys  0m, 17s
>
> reiser4(cryptcompress, lzo1, 64K)
> real 1m, 35s
> sys 0m, 14s
>
>
>
>

