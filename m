Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSGQOeN>; Wed, 17 Jul 2002 10:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSGQOeN>; Wed, 17 Jul 2002 10:34:13 -0400
Received: from imr2.ericy.com ([198.24.6.3]:33463 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id <S314938AbSGQOeM>;
	Wed, 17 Jul 2002 10:34:12 -0400
Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8303A070F6@eammlnt051.lmc.ericsson.se>
From: "Philippe Veillette (LMC)" <Philippe.Veillette@ericsson.ca>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: question about the receiving ip path
Date: Wed, 17 Jul 2002 10:37:04 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With the lsm hook, I have found that each time I receive a packet (a UDP
packet) it's allocating a sk_buff, after, it's cloning it, then it free
it!!!, then i receive the first skbuff and then it's freed.  Should i add
that i didn't see the cloned sk_buff.

Ok, i know that there should be something done with the cloned sk_buff,
since if it's not the case, if only slowing the receving side for no good
reason...

I would like to know if the cloned sk_buff is really needed, and also what
is the path used, (how to find it, since it's a maze to try to figure out
the receiving path, by looking at place where sk_buff are cloned, since I
don't know the entry function).  At least knowing the entry function could
help a lot.

Philippe
