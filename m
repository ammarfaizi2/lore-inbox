Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEBpT>; Sat, 4 Nov 2000 20:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEBpJ>; Sat, 4 Nov 2000 20:45:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129030AbQKEBpA>; Sat, 4 Nov 2000 20:45:00 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux-2.4.0-test10
Date: 4 Nov 2000 17:44:57 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u2e2p$2ju$1@cesium.transmeta.com>
In-Reply-To: <E13qiR9-0008FT-00@the-village.bc.nu> <20001102171717.L1876@redhat.com> <20001104194937.E3423@wonderland.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001104194937.E3423@wonderland.linux.it>
By author:    "Marco d'Itri" <md@Linux.IT>
In newsgroup: linux.dev.kernel
>
> On Nov 02, "Stephen C. Tweedie" <sct@redhat.com> wrote:
> 
>  >2.2 O_SYNC is actually broken too --- it doesn't sync all metadata (in
>  >particular, it doesn't update the inode), but I'd rather fix that for
>  >2.4 rather than change 2.2, as the main users of O_SYNC, databases,
>  >are writing to preallocated files anyway.
> What about fsync(2)? Will it update metadata too?
> 

It better.  fdatasync(), if implemented, is allowed to skip that
requirement.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
