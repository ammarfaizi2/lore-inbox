Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSKOLbW>; Fri, 15 Nov 2002 06:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266173AbSKOLa4>; Fri, 15 Nov 2002 06:30:56 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266125AbSKOL3c>;
	Fri, 15 Nov 2002 06:29:32 -0500
Date: Tue, 12 Nov 2002 21:04:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@digeo.com>,
       Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Failed writes marked clean?
Message-ID: <20021112200421.GC861@zaurus>
References: <3DCC1EB5.4020303@google.com> <3DCC252F.65C0F70B@digeo.com> <20021108233530.GA23888@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108233530.GA23888@think.thunk.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In some circumstances, it may actually make sense to try writing a
> random block of data to the disk, since that may force the disk to
> remap the block.  (Disks generally only remap a block from the pool of
> spare blocks on writes, not on reads.)
> 
> Unfortuantely, if the error was just a transient one, you might end up
> smashing the block when you write random garbage in an attempt to
> remap the block.  So perhaps the answer is to retry the read, and if
> that fails, *then* try to do a forced rewrite of the block.
> 

Retrying is not enough. I've seen a notebook
overheating: its cpu was still okay but HDD
was too hot and started acting crazy.  I got
away with 2 bad blocks and FS survived. If
kernel tried to do something clever it would
probably make corruption much worse.
				Pavel

-- 
				Pavel
My velo broke, so I got Zaurus. If you have Philips Velo 1 you don't need...
