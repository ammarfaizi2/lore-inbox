Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKBXyc>; Thu, 2 Nov 2000 18:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbQKBXyW>; Thu, 2 Nov 2000 18:54:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129213AbQKBXyD>; Thu, 2 Nov 2000 18:54:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: select() bug
Date: 2 Nov 2000 15:53:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tsupp$gh8$1@cesium.transmeta.com>
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu> <3A01FC44.8A43FE8B@iname.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A01FC44.8A43FE8B@iname.com>
By author:    Paul Marquis <pmarquis@iname.com>
In newsgroup: linux.dev.kernel
>
> Okay, I see your point, thanks.  A couple of comments/questions:
> 
> - Does this make sense with devices with small kernel buffers?  From
> my experimentation, pipes on Linux have a 4K buffer and tend to be
> read and written very quickly.
> 
> - If I'm correct that pipes have a 4K kernel buffer, then writing 1
> byte shouldn't cause this situation, as the buffer is well more than
> half empty.  Is this still a bug?
> 
> Semantic issues aside, since Apache does the test I mentionned earlier
> to determine child status and since it could be misled, should this
> feature be turned off?
> 
> Thanks for your input.
> 

Has anyone considered the possibility of expanding the buffer of
high-traffic pipes?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
