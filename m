Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268536AbTCAI6T>; Sat, 1 Mar 2003 03:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbTCAI6T>; Sat, 1 Mar 2003 03:58:19 -0500
Received: from ns.suse.de ([213.95.15.193]:37133 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268536AbTCAI6T>;
	Sat, 1 Mar 2003 03:58:19 -0500
Date: Sat, 1 Mar 2003 10:08:39 +0100
From: Andi Kleen <ak@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030301090839.GA11997@wotan.suse.de>
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com> <20030228185910.GA5694@wotan.suse.de> <20030301004942.GA16973@delft.aura.cs.cmu.edu> <20030301011723.GA31126@wotan.suse.de> <20030301043131.7D5301058@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301043131.7D5301058@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder what would happen if you reordered the chains moving a 'found'
> dentry to the front of the chain?  If this could be done without 
> excessive locking it might help keep hot entries quickly accessable.
> This operation should be cheaper given you are using hlists.

You would need to fetch a spinlock for LRU, while the current lookup
runs completely lockless.

-Andi
