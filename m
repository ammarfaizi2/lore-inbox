Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282877AbRK0Iff>; Tue, 27 Nov 2001 03:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282876AbRK0If0>; Tue, 27 Nov 2001 03:35:26 -0500
Received: from oker.escape.de ([194.120.234.254]:31005 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S282873AbRK0IfH>;
	Tue, 27 Nov 2001 03:35:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] omnibus header cleanup, certification
In-Reply-To: <20011127061714.A41881@cantrip.org> <3C03315C.5060203@zytor.com>
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 27 Nov 2001 09:32:09 +0100
In-Reply-To: <3C03315C.5060203@zytor.com>; from "H. Peter Anvin" on Mon, 26 Nov 2001 22:23:24 -0800
Message-ID: <m2bshohawm.fsf@isnogud.escape.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> It's also worth noting that there is nothing that it can get confused 
> with and still have a compilable expression.

Well, there are cases, where -1 and (-1) make a difference (see below)
but these are extremely unlikely to appear in the kernel src code.
Thus, I also think these patches are unnecessary.

For example,

    int *p;            and       int *p
    -1[p];                       (-1)[p];

are both valid and compilable code segments, with no undefined or
implementation-defined behavior (as long as p points to an element of
an array other than the first and last), and both code segments do
different things.


> I don't believe the unary-expression patches are necessary.  They are, 
> of course, harmless, except for the fact that my eyes glazed over 
> staring at page after page of these, which very few actual potential (!) 
> bugs (there were a couple, like the iopage+ ones...)

ack.


urs
