Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268327AbTCAEUv>; Fri, 28 Feb 2003 23:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268451AbTCAEUv>; Fri, 28 Feb 2003 23:20:51 -0500
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:3236 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268327AbTCAEUt>; Fri, 28 Feb 2003 23:20:49 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH] New dcache / inode hash tuning patch
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Fri, 28 Feb 2003 23:31:31 -0500
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com> <20030228185910.GA5694@wotan.suse.de> <20030301004942.GA16973@delft.aura.cs.cmu.edu> <20030301011723.GA31126@wotan.suse.de>
Organization: me
User-Agent: KNode/0.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030301043131.7D5301058@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> The hash function isn't good and the hash chains are far from evenly
> distributed. There are typically 30-40% empty buckets, while some
> others are rather long.
> 
> In addition I think only a small fraction of the dentries are actually
> hot. (no numbers on that, sorry)

I wonder what would happen if you reordered the chains moving a 'found'
dentry to the front of the chain?  If this could be done without 
excessive locking it might help keep hot entries quickly accessable.
This operation should be cheaper given you are using hlists.

Ed Tomlinson

