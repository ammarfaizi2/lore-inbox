Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131702AbQK2RNC>; Wed, 29 Nov 2000 12:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131708AbQK2RMx>; Wed, 29 Nov 2000 12:12:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:36317 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131702AbQK2RMs>;
        Wed, 29 Nov 2000 12:12:48 -0500
Date: Wed, 29 Nov 2000 11:42:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Hugh Dickins <hugh@veritas.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291612190.1306-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011291130460.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> All I am saying is that if open on HP/UX allows writing but access denies
> it, it is definitely a bug (in HP/UX). Let's remember why access(2) was
> invented at all -- to allow setuid-privileged programs to do permission
> checks based on real uid instead of relying on open(2) to fail. This
> should make it clear that the two (access(2) and open(2)) should behave
> identically modulo the euid->ruid transformation.

Umm... Correction: open() may fail when access() succeeds (e.g. if you've
got too many opened descriptors, etc.), but it shouldn't be other way
round. However, if access() returns an error open() should also fail.
 
> Regards,
> Tigran
> 
> PS. This is the sort of dicussion where openly showing snippets of
> proprietary UNIX source code would benefit but, alas, we can't...

Considering your previous workplace... How does official SVR{4,5} behave?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
