Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129340AbQK1SQF>; Tue, 28 Nov 2000 13:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130312AbQK1SPz>; Tue, 28 Nov 2000 13:15:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64233 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129340AbQK1SPq>;
        Tue, 28 Nov 2000 13:15:46 -0500
Date: Tue, 28 Nov 2000 12:45:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.4.21.0011281614350.1254-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011281233540.9313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Tigran Aivazian wrote:

> it is not basic at all. The problems you point out are extremely complex
> (at least the fd in transit issue, definitely is). 
> 
> So, yes it requires a bit more thought. I will come back when the issues
> you pointed out are dealt with. Someone has added the 'files' field to the
> 'struct user_struct' so someone must have meant to put support for this
> field to be something other than the meaningless 0 it currently is.

You know, in such cases usual course of actions is to remove the bloody
thing. It's not used, it's not set to anything useful, semantics is
fundamentally non-obvious, so Occam's Razor applies. Until somebody
comes up with a reasonable use _and_ clear semantics... Trying to invent
one simply because the field is there looks, erm, odd.

-- 
POSIX should be renamed to FPOSIX - it is U*IX-like, all right, but POS is
too mild to describe its quality.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
