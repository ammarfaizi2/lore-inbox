Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRCZV2h>; Mon, 26 Mar 2001 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRCZV2S>; Mon, 26 Mar 2001 16:28:18 -0500
Received: from suntan.tandem.com ([192.216.221.8]:39598 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S129242AbRCZV2N>; Mon, 26 Mar 2001 16:28:13 -0500
Message-ID: <3ABFB20E.DFB37BFA@kahuna.cag.cpqcorp.net>
Date: Mon, 26 Mar 2001 13:18:06 -0800
From: John Byrne <jbyrne@kahuna.cag.cpqcorp.net>
Reply-To: John.L.Byrne@compaq.com
X-Mailer: Mozilla 4.61 [en] (X11; I; UnixWare 5 i386)
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Larger dev_t
> 
On Sat Mar 24 2001 Linus Torvalds (torvalds@transmeta.com) wrote:
> There is no way in HELL I will ever accept a 64-bit dev_t.
> 
> I _will_ accept a 32-bit dev_t, with 12 bits for major numbers, and 20
> bits for minor numbers.
> 

Do you have any interest in doing away with the concept of major and
minor numbers altogether; turning the dev_t into an opaque unique id?

At the application level, the kinds of information that is derived from
the major/minor number should probably be derived in some other manner
such as a library or system call. Code that determines device type by
comparing with the major/minor numbers should probably be discouraged in
the long run and this could be a good time to start.

John Byrne
