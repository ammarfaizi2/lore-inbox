Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbRBFSTr>; Tue, 6 Feb 2001 13:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRBFSTh>; Tue, 6 Feb 2001 13:19:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:21770 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129636AbRBFSTb>;
	Tue, 6 Feb 2001 13:19:31 -0500
Date: Tue, 6 Feb 2001 19:18:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061225330.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102061841170.6277-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> Let me just emphasize what Stephen is pointing out: if requests are
> properly merged at higher layers, then merging is neither required nor
> desired. [...]

this is just so incorrect that it's not funny anymore.

- higher levels just do not have the kind of knowledge lower levels have.

- merging decisions are often not even *deterministic*.

- higher levels do not have the kind of state to eg. merge requests done
  by different users. The only chance for merging is often the lowest
  level, where we already know what disk, which sector.

- merging is not even *required* for some devices - and chances are high
  that we'll get away from this inefficient and unreliable 'rotating array
  of disks' business of storing bulk data in this century. (solid state
  disks, holographic storage, whatever.)

i'm truly shocked that you and Stephen are both saying this.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
