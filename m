Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbTF3Gxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 02:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbTF3Gxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 02:53:37 -0400
Received: from [213.171.53.133] ([213.171.53.133]:8712 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S265779AbTF3Gx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 02:53:28 -0400
Date: Mon, 30 Jun 2003 10:09:22 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, wli@holomorphy.com,
       andrea@suse.de
Subject: Re: [VM] writes starve reads in 2.5.72-bk1
Message-Id: <20030630100922.26db2333.deepfire@ibe.miee.ru>
In-Reply-To: <20030630100258.3c17ee04.deepfire@ibe.miee.ru>
References: <20030630100258.3c17ee04.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003 10:02:58 +0400
Samium Gromoff <deepfire@ibe.miee.ru> wrote:

> load:                           gzipping a 128M file, with "gzip file"
> CPU:                            p3-500
> physical RAM installed:         256M
> kernel:                         2.5.72-bk1
> drive:                          one 10krpm IBM
> controller:                     DAC960PL RAID controller
> 
> 0  1   9384   3960  33640 116184    0    0  1280  4096 1022   122 63  7  0 30
> 1  0   9384   4016  33220 116568    0    0  1792     0 1096   122 81  7  0 12
> 1  0   9384   3624  33156 117112    0    0  2048     0 1036   119 92  8  0  0
> 1  1   9384   4856  32024 116876    0    0  1024 11432 1092   145 48  5  2 44
> 0  2   9384   4632  32024 117164    0    0   128  7288 1120   208  8  2  0 90
> 0  2   9384   4072  32024 117676    0    0   256  9172 1149   224 12  2  0 86
> 1  0   9384   3624  31516 118684    0    0   896   944 1146   145 38  4  0 58
> 1  0   9384   3288  30916 119764    0    0  2048     0 1031   117 92  8  0  0
> 1  0   9384   4128  30620 119228    0    0  1920    92 1062   160 92  7  1  0
> 1  0   9384   3960  30208 120120    0    0  2048     0 1033   115 93  7  0  0
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 
> problem as i see it:
> 
> although the drive is mostly idle since the cpu is too slow to max it out,
> reads are starved during bursts of gzipped data writeouts,
> causing gzip to spend its time on sleeping on request completion.

	Now i notice that the anticipatory sheduler isn`t in the mainline...
 So all this sounds a little bit old...

	Anyways, hope it helps...
> 
> regards, Samium Gromoff


-- 
