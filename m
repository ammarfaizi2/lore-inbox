Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269341AbTCDJKU>; Tue, 4 Mar 2003 04:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269342AbTCDJKU>; Tue, 4 Mar 2003 04:10:20 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:21476 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S269341AbTCDJKU>; Tue, 4 Mar 2003 04:10:20 -0500
Date: Tue, 4 Mar 2003 10:20:31 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vlad Harchev <hvv@hippo.ru>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptofs on raid1 - what will be cached and how many times
Message-ID: <20030304092031.GB6583@wohnheim.fh-wedel.de>
References: <20030302105634.GA4258@h> <20030303093832.GA4601@h> <15971.52790.676134.722437@notabene.cse.unsw.edu.au> <20030304093020.GA4024@h>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030304093020.GA4024@h>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 March 2003 13:30:20 +0400, Vlad Harchev wrote:
> 
>  Sorry for confusion - I meant loopback-based crypto filesystem - e.g. loop-aes
> based (loop-aes.sourceforge.net) or CryptoAPI-based (www.kerneli.org) - both
> are loopback-based filesystem (one has to call losetup(8) to point out chipher,
> a password..)

Loopback with encryption is not the same as a crypto filesystem.
Loopback encryption works transparently with any (non-)crypto fs.

A potential attacker can use this to look for the ext2 superblock,
which gives him the same data both encrypted an unencrypted. A real
cryptofs would go through great pains to take such advantages away.

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
