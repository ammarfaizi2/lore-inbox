Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288673AbSADPRa>; Fri, 4 Jan 2002 10:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288670AbSADPRL>; Fri, 4 Jan 2002 10:17:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51925 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288655AbSADPQ7>;
	Fri, 4 Jan 2002 10:16:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jan 2002 15:16:32 GMT
Message-Id: <UTC200201041516.PAA224847.aeb@cwi.nl>
To: adilger@turbolabs.com, phillips@bonn-fries.net
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Cc: acme@conectiva.com.br, ion@cs.columbia.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    grep -r "sizeof (" linux | wc -l,
    grep -r "sizeof(" linux | wc -l:

    sizeof (foo): 1611, sizeof(foo): 19364 => -bs should be removed

    > > -psl: Put the type of a procedure on the line before its name.

    grep -r -B2 "^{" linux | grep "^[^ ]*(" | wc -l,
    grep -r -B2 "^{" linux | grep "^.* .*(" | wc -l:

    int
    foo(int x): 11408, int foo(int x): 57275 => -psl should be removed

I do not think good style is best defined by majority vote.

    grep -r "\*) [a-z_(]" . | wc -l,
    grep -r "\*)[a-z_(]" . | wc -l:

    (void *) foo: 11274, (void *)foo: 17062 => -ncs should be added

    > Not putting a space after a cast is gross ;)

    Well, it seems you are in the (slight) minority on this one.  It's not as
    big a margin as the other ones, but still measurable.  I wasn't able to
    find any examples from the King Penguin himself on this one.

Read old kernel sources.

        de = (struct minix_dir_entry *) (offset + bh->b_data);

	:"S" ((long) name),"D" ((long) buffer),"c" (len)

	if (32 != sizeof (struct minix_inode))



