Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273823AbRIRD6V>; Mon, 17 Sep 2001 23:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273824AbRIRD6L>; Mon, 17 Sep 2001 23:58:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28704 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273823AbRIRD6D>; Mon, 17 Sep 2001 23:58:03 -0400
Date: Tue, 18 Sep 2001 05:58:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918055823.S698@athlon.random>
In-Reply-To: <20010918053711.P698@athlon.random> <Pine.LNX.4.21.0109172314130.7032-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109172314130.7032-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Sep 17, 2001 at 11:25:09PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 11:25:09PM -0300, Marcelo Tosatti wrote:
> My point is: we're not going to start aging pte's until we have a
> zone shortage, right ?

correct, so we don't waste time if there's only filesystem cache
pressure during the whole kernel uptime (not an unlikely scenario if you
have enough ram like on servers).

> I really think this will cause problems in practice, Andrea.

yes, this hiding could infact explain the report you posted. I'll try to
reproduce with highmem emulation and to fix it as soon as I can
reproduce, also if you are interested to hack on it too feel free to
send patches of course. thanks.

Andrea
