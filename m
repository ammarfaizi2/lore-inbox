Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277968AbRJOCG6>; Sun, 14 Oct 2001 22:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277973AbRJOCGr>; Sun, 14 Oct 2001 22:06:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38664 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277968AbRJOCGo>; Sun, 14 Oct 2001 22:06:44 -0400
Date: Sun, 14 Oct 2001 19:06:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] "Text file busy" when overwriting libraries
In-Reply-To: <E15swoM-0000de-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110141900200.15745-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Oct 2001, Alan Cox wrote:
>
> > We already can open an exec only file just open("file", 0).
>
> Wrong.

For exact details: there's a magic value, but it's 3.

	open("file", 3)

will open the filename with neither read nor write permissions, but it
will actually _require_ both read- and write- permissions, and it was
historically a way to open a device just for ioctl's.

I don't think anybody actually uses it any more.

		Linus

