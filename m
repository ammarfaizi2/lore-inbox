Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131189AbRBUGjg>; Wed, 21 Feb 2001 01:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRBUGj0>; Wed, 21 Feb 2001 01:39:26 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:18075 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131189AbRBUGjQ>; Wed, 21 Feb 2001 01:39:16 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
To: linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2001 21:35:15 -0500
In-Reply-To: <E14VNAU-00014j-00@the-village.bc.nu>
Organization: me
User-Agent: KNode/0.4beta4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20010221023515.6DF8E18C99@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> probably a bad idea to use it, because in theory at least the VFS layer
>> might decide to switch the hash function around. I'm more interested in
>> hearing whether it's a good hash, and maybe we could improve the VFS hash
>> enough that there's no reason to use anything else..
> 
> Reiserfs seems to have done a lot of work on this and be using tea, which is
> also nice as tea is non trivial to abuse as a user to create pessimal file
> searches intentionally

The default in reiserfs is now the R5 hash, but you are right that lots of efforts went 
into finding this hash.  This includes testing various hashes on real directory 
structures to see which one worked best.  R5 won.

Ed Tomlinson
