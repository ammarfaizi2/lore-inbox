Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269542AbRHHVQm>; Wed, 8 Aug 2001 17:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269546AbRHHVQc>; Wed, 8 Aug 2001 17:16:32 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:51985 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269545AbRHHVQV>; Wed, 8 Aug 2001 17:16:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] one of $BIGNUM devfs races
Date: 8 Aug 2001 14:16:03 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ksa6j$jo7$1@cesium.transmeta.com>
In-Reply-To: <E15UC9a-0003kt-00@the-village.bc.nu> <Pine.GSO.4.21.0108071510390.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0108071510390.18565-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> It is not reliable. E.g. on NFS inumbers are not unique - 32 bits is
> not enough.
> 

Unfortunately there is a whole bunch of other things too that rely on
it, and *HAVE* to rely on it -- (st_dev, st_ino) are defined to
specify the identity of a file, and if the current types aren't large
enough we *HAVE* to go to new types.  THERE IS NO OTHER WAY TO TEST
FOR FILE IDENTITY IN UNIX, and being able to perform such a test is
vital for many things, including security and hard link detection
(think tar, cpio, cp -a.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
