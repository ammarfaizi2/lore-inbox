Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272238AbTHDUcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272239AbTHDUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:32:15 -0400
Received: from zeus.kernel.org ([204.152.189.113]:35548 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272238AbTHDUcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:32:14 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Werner Almesberger <werner@almesberger.net>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 4 Aug 2003 13:24:19 -0700 (PDT)
Subject: Re: TOE brain dump
In-Reply-To: <20030804170921.O5798@almesberger.net>
Message-ID: <Pine.LNX.4.44.0308041316170.7534-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Werner Almesberger wrote:

> David Lang wrote:
> > I would think that it's much more difficult to run NUMA across different
> > types of CPU's
>
> I'd view this as a new and interesting challenge :-) Besides,
> if one would use Alan's idea, and just use an amd64, or such,
> the CPUs wouldn't be all that different in the end.

you missed Alan's point, he was saying you don't do TOE on the NIC, you
just add another CPU to your main system and use non-TOE NIC's the way you
do today.

> > then it would be to run a seperate kernel on the NIC.
>
> Yes, but that separate kernel would need new administrative
> interfaces, and things like route changes would be difficult
> to handle. (That is, if you still want this to appear as a
> single system to user space.) It would certainly be better
> that running a completely proprietary solution, but you still
> get a few nasty problems.

Any time you create a cluster of machines you want to create som nice
administrative interfaces for them to maintain your own sanity (you don't
think sysadmins login to every machine on a 1000 node beowolf cluster do
you :-)

in trying to run a single kernel across different types of CPU's you run
into some really nasty problems (different machine code, and even if it's
the same family of processor it could require very different
optimizations, imagine the two processor types useing different word
lengths or endian order)

Larry McVoy has the right general idea when he says buy another box to do
the job, he is just missing the idea that there are some advantages of
coupling the cluster more tightly then you can do with a seperate box.

David Lang
