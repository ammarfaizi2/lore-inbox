Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263801AbUECReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbUECReF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUECReF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 13:34:05 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:17886 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263801AbUECReD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:34:03 -0400
Date: Mon, 3 May 2004 19:33:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@stanford.edu,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Ext2-devel] [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors get ignored, causing non-empty dir to be deleted
Message-ID: <20040503173320.GA10655@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU> <20040427074455.GD30529@schnapps.adilger.int> <20040503141001.GA23656@wohnheim.fh-wedel.de> <20040503161606.GJ1334@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503161606.GJ1334@schnapps.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004 10:16:06 -0600, Andreas Dilger wrote:
> On May 03, 2004  16:10 +0200, Jörn Engel wrote:
> > 
> > Do you mind if I doubt the sanity of whoever made that decision?  When
> > my hard drive fails, I don't care about writing to the fs too much
> > anymore, I want to *notice* the failure early and to *read* as much as
> > possible, then put the drive on a pile for test hardware.
> 
> If that's what you want, then mount the filesystem with "errors=remount-ro"
> and you will get it.  You can even mount it with "errors=panic" so that the
> node reboots and does a full fsck immediately.  For users that have a few
> bad blocks on their disk and can't afford to throw the whole disk away this
> is a reasonable course of action.

Ok, "errors=remount-ro" is good enough for me.  For the record, do
non-historic disks with a few bad blocks still exist?  I though the
driver firmware already detected those and used spare blocks at one
side of the disk as a replacement.  Nicely visible when sequential
read performance over the whole disk has a few non-continuous spots.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
