Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSERSaG>; Sat, 18 May 2002 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313731AbSERSaF>; Sat, 18 May 2002 14:30:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14856 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313690AbSERSaF>;
	Sat, 18 May 2002 14:30:05 -0400
Message-ID: <3CE69E77.5D7AF4AF@zip.com.au>
Date: Sat, 18 May 2002 11:33:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mikeH <mikeH@notnowlewis.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.33.0205180051100.3170-100000@penguin.transmeta.com> <3CE61651.3020006@notnowlewis.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikeH wrote:
> 
> Whats the state of ext3 in this release? I seem to remember reading
> there were some corruption issues.

data=journal is not in very good state.

data=ordered works for normal use, but it will fail in heavy testing
on SMP due to exposure of preexisting bugs.  I have forward ported a
couple of Stephen's patches which appear to fix that up.

data=writeback should be OK.

I'll get the ext3 fixes out over the next few days.
