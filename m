Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277484AbRJJWJF>; Wed, 10 Oct 2001 18:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277476AbRJJWI4>; Wed, 10 Oct 2001 18:08:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14332 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277440AbRJJWIn>;
	Wed, 10 Oct 2001 18:08:43 -0400
Date: Wed, 10 Oct 2001 18:09:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mingming cao <cmm@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
In-Reply-To: <3BC4EFFC.42ACE59E@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0110101806480.21168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, Mingming cao wrote:
 
> I thought about the case when rmdir() on the cwd of other processes,
> but, as you said, that is implementation dependent. However rmdir() on
> "." does returns EBUSY error. Should not we keep the rmdir() behavior
> consistent: rmdir() on the current working directory of the current
> process is not OK?

We do.  It's not just ".",  "foo/bar/." is also prohibited.  IOW, the
rule is "the last component of name should not be . or ..".  Please,
look through archives - it had been beaten to death many times.

