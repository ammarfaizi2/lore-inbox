Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273047AbRIIU4W>; Sun, 9 Sep 2001 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273046AbRIIU4M>; Sun, 9 Sep 2001 16:56:12 -0400
Received: from [208.129.208.52] ([208.129.208.52]:57604 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273042AbRIIU4D>;
	Sun, 9 Sep 2001 16:56:03 -0400
Message-ID: <XFMail.20010909135844.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33L.0109091745130.21049-100000@duckman.distro.conectiva>
Date: Sun, 09 Sep 2001 13:58:44 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Purpose of the mm/slab.c changes
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09-Sep-2001 Rik van Riel wrote:
> On Sun, 9 Sep 2001, Davide Libenzi wrote:
> 
>> Do You see it as a plus ?
>> The new allocated slab will be very likely written ( w/o regard
>> about the old content ) and an L2 mapping will generate
>> invalidate traffic.
> 
> If your invalidates are slower than your RAM, you should
> consider getting another computer.

You mean a Sun, that uses a separate bus for snooping ? :)
Besides to not under estimate the cache coherency traffic ( that on many CPUs
uses the main memory bus ) there's the fact that the old data eventually
present in L2 won't be used by the new slab user.




- Davide

