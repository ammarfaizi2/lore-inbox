Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278494AbRJVKko>; Mon, 22 Oct 2001 06:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278492AbRJVKke>; Mon, 22 Oct 2001 06:40:34 -0400
Received: from [64.71.202.149] ([64.71.202.149]:55813 "HELO mail.thedeacon.org")
	by vger.kernel.org with SMTP id <S278491AbRJVKkV>;
	Mon, 22 Oct 2001 06:40:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paul Kreiner <deacon@thedeacon.org>
To: vherva@niksula.hut.fi
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Date: Sun, 21 Oct 2001 23:48:15 -0600
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, cdwrite@other.debian.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011022104014.8FFFA2379E@mail.thedeacon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. I updated to 1.10 from redhat rawhide, but as said it didn't work at all
> with 2.2 ("failed to mmap /dev/null" or something) so I went back to 1.9. I
> could retry now that I've updated the machine in question to 2.4. (I can
> also see if the 2.2 /dev/null error reproduces if you are interested.) I'll
> retry too large image with 1.10 and report back to you, but I fear it is a
> kernel bug.
 
I believe I ran into this same cdrecord "fail to mmap /dev/null" issue 
before.  The fix (aside from upgrading your kernel to 2.4.x) is to pass 
"fs=0" to cdrecord.  According to the docs, this disables the in-memory FIFO.

Cheers,
Paul Kreiner
