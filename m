Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTCAMYC>; Sat, 1 Mar 2003 07:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTCAMYC>; Sat, 1 Mar 2003 07:24:02 -0500
Received: from tomts25.bellnexxia.net ([209.226.175.188]:58542 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266175AbTCAMYC>; Sat, 1 Mar 2003 07:24:02 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Date: Sat, 1 Mar 2003 07:34:44 -0500
User-Agent: KMail/1.5.9
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <20030301043131.7D5301058@oscar.casa.dyndns.org> <20030301090839.GA11997@wotan.suse.de>
In-Reply-To: <20030301090839.GA11997@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303010734.45441.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 1, 2003 04:08 am, Andi Kleen wrote:
> > I wonder what would happen if you reordered the chains moving a 'found'
> > dentry to the front of the chain?  If this could be done without
> > excessive locking it might help keep hot entries quickly accessable.
> > This operation should be cheaper given you are using hlists.
>
> You would need to fetch a spinlock for LRU, while the current lookup
> runs completely lockless.

You would have to lock the chain IF the dentry was not at the head.  Would
be interesting to see if this locking would hurt much - since hot 
dentries would not require a lock...

Ed

