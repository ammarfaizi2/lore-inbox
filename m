Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267758AbUHRVhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUHRVhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHRVhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:37:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49026 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267758AbUHRVgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:36:44 -0400
Date: Wed, 18 Aug 2004 17:36:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "David S. Miller" <davem@redhat.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
In-Reply-To: <20040818210503.GG11200@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0408181731220.17296@chaos>
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818205338.GF11200@holomorphy.com>
 <20040818135638.4326ca02.davem@redhat.com> <20040818210503.GG11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, William Lee Irwin III wrote:

> On Wed, 18 Aug 2004 13:53:38 -0700 William Lee Irwin III wrote:
> >> Once it's decided how many it really takes, I'll fix up sparc32 as-needed.
>
> On Wed, Aug 18, 2004 at 01:56:38PM -0700, David S. Miller wrote:
> > (sorry for the emply reply previously)
> > It needs 6 unless we start passing in a 64-bit value to
> > io_remap_page_range()
> > for the 'offset' parameter.
> > Physical I/O addresses are 36-bits or so on sparc32 systems, which is
> > why we need to pass in "offset" and "space".
>

Maybe a pointer?

> We should pass 64-bit values to remap_page_range() also, then. Or
> perhaps passing pfn's to both suffices, as it all has to be page
> aligned anyway.
>
>
> -- wli

With a pointer to some kind of descriptor (structure), the arch-dependent
pointer size is handled by the compiler/linker and the arch-dependent
content is handled with the arch-dependent header defining the
structure. You get to keep both pieces and they don't break when
porting to a new box.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


