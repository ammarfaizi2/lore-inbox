Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130101AbQJ0Auw>; Thu, 26 Oct 2000 20:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130455AbQJ0Aum>; Thu, 26 Oct 2000 20:50:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130101AbQJ0Aue>; Thu, 26 Oct 2000 20:50:34 -0400
Subject: Re: kqueue microbenchmark results
To: jlemon@flugsvamp.com (Jonathan Lemon)
Date: Fri, 27 Oct 2000 01:50:40 +0100 (BST)
Cc: gid@cisco.com (Gideon Glass), jlemon@flugsvamp.com (Jonathan Lemon),
        sim@stormix.com (Simon Kirby), dank@alumni.caltech.edu (Dan Kegel),
        chat@freebsd.org, linux-kernel@vger.kernel.org
In-Reply-To: <20001026115057.A22681@prism.flugsvamp.com> from "Jonathan Lemon" at Oct 26, 2000 11:50:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13oxjH-00041y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kqueue currently does this; a close() on an fd will remove any pending
> events from the queues that they are on which correspond to that fd.

This seems an odd thing to do. Surely what you need to do is to post a
'close completed' event to the queue. This also makes more sense when you
have a threaded app and another thread may well currently be in say a read
at the time it is closed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
