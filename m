Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273665AbRIWWhw>; Sun, 23 Sep 2001 18:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273667AbRIWWhc>; Sun, 23 Sep 2001 18:37:32 -0400
Received: from anime.net ([63.172.78.150]:22538 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S273665AbRIWWh1>;
	Sun, 23 Sep 2001 18:37:27 -0400
Date: Sun, 23 Sep 2001 15:36:25 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: "Garst R. Reese" <reese@isn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: do we need 10 copies?
In-Reply-To: <Pine.LNX.4.33.0109232106020.14414-100000@vaio>
Message-ID: <Pine.LNX.4.30.0109231531370.9187-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Kai Germaschewski wrote:
> On Sun, 23 Sep 2001, Garst R. Reese wrote:
> > This table (512 bytes) and the code to implement crc-ccit is replicated
> > in 10 drivers. ppp-async even exports it. Surely there is a better way.
> As for the ISDN code (4 copies), there is the plan to use a a common HDLC
> en/decoding module, however that's a 2.5 thing. I'll take a look if I can
> find a generic solution then, but it might turn out difficult - having a
> module of its own just for that table wastes nearly a page, so that's
> probably worse than the current state of affairs.

I think the point is not so much that it tries to save memory, but
that it avoids duplicated code and errors. IIRC there were bugs in
previous kernels related to typos/errors in the individual crc tables...

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

