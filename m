Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264318AbRFGEoH>; Thu, 7 Jun 2001 00:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264317AbRFGEn5>; Thu, 7 Jun 2001 00:43:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10129 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264318AbRFGEnm>;
	Thu, 7 Jun 2001 00:43:42 -0400
Date: Thu, 7 Jun 2001 00:43:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed
 in the
In-Reply-To: <tgbso0diih.fsf@mercury.rus.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.21.0106070042280.11086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 Jun 2001, Florian Weimer wrote:

> Matthias Urlichs <smurf@noris.de> writes:
> 
> > Select is defined as to return, with the appropriate bit set, if/when
> > a nonblocking read/write on the file descriptor won't block. You'd get
> > EBADF in this case, therefore causing the select to return would be a
> > Good Thing.
> 
> How do you avoid race conditions if more than one thread is creating
> file descriptors?  I think you can only do that under very special
> circumstances, and it definitely requires some synchronization.

The same way as you do it for many threads doing any allocations.

