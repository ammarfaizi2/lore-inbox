Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312162AbSCTUsr>; Wed, 20 Mar 2002 15:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312157AbSCTUsh>; Wed, 20 Mar 2002 15:48:37 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:57291 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S293226AbSCTUsX>; Wed, 20 Mar 2002 15:48:23 -0500
Date: Wed, 20 Mar 2002 16:05:50 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: VM_EXEC cicular dependancies
Message-ID: <Pine.LNX.4.40.0203201559220.7618-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still trying to get 2.5.7 to compile for the Alpha.

I've got it down to a handful of undefined symbols at link time, the worst
of which are the "flush_cache" like functions which should be included
from <asm/pgtable.h> but as of now for the Alpha code they reside in
<asm/pgalloc.h>.

So I moved the defines over to pgtable.h, but I find one of the functions
uses the "VM_EXEC" define from <linux/mm.h>.  As luck would have it, mm.h
includes pgtable.h.

What is the prefered method for resolving this?

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

