Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136487AbREDTeb>; Fri, 4 May 2001 15:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136169AbREDTeV>; Fri, 4 May 2001 15:34:21 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:6301 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136138AbREDTeF>; Fri, 4 May 2001 15:34:05 -0400
Date: Fri, 4 May 2001 12:30:37 -0700 (PDT)
From: Seth Goldberg <bergsoft@home.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, bergsoft@home.com
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
In-Reply-To: <3AF2FF93.44A2C49@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0105041226300.325-100000@c1162825-a.snvl1.sfba.home.com.>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Manfred Spraul wrote:

| > ---
| > >       __asm__ __volatile__ (
| > 158c157
| > <               "3: movw $0x1AEB, 1b\n"
| > ---
| > >               "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
| > 166c165
| > < */
| > ---
| > >
| > 170c169
| > <               "1: nop\n" /* prefetch 320(%0)\n" */
| > ---
| > >               "1: prefetch 320(%0)\n"                                         
| > -------------------------
| >   Please let me know if that makes sense :).
| 
| Very interesting.
| You've removed only the prefetch 320(%0), not the other prefetch
| instructions?

  No, I have removed them all -- I just commented the block above it
completely out :). (maybe you didn't see the whole patch?)

  --Seth



