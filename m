Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSGRPHE>; Thu, 18 Jul 2002 11:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318120AbSGRPG7>; Thu, 18 Jul 2002 11:06:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21253 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318113AbSGRPG4>; Thu, 18 Jul 2002 11:06:56 -0400
Date: Thu, 18 Jul 2002 12:09:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <Pine.LNX.3.96.1020718104332.7522A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0207181208020.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Bill Davidsen wrote:

> I think I'm missing a part of this, the "a snapshot is created" sounds a
> lot like "here a miracle occurs." Where is this snapshot saved? And how
> do you take it in one sec regardless of f/s size?

LVM. Systems like LVM already provide a logical->physical block
mapping on disk, so they might as well provide multiple mappings.

If the live filesystem writes to a particular disk block, the
snapshot will keep referencing the old blocks while the filesystem
gets to work on its own data. Copy on Write snapshots for block
devices...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

