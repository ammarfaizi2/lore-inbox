Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288948AbSA3TUQ>; Wed, 30 Jan 2002 14:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287939AbSA3TUG>; Wed, 30 Jan 2002 14:20:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:51727 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284902AbSA3TUA>;
	Wed, 30 Jan 2002 14:20:00 -0500
Subject: Re: BKL in tty code?
From: Robert Love <rml@tech9.net>
To: Alex Khripin <akhripin@mit.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020130184950.GA22442@morgoth.mit.edu>
In-Reply-To: <20020130184950.GA22442@morgoth.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 14:25:59 -0500
Message-Id: <1012418760.3219.43.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 13:49, Alex Khripin wrote:

> I'm very much a newbie, and I'm wondering about the big kernel locks
> in tty_io.c. What exactly are the locks in the read and write for? Is the
> tty device that contested? Couldn't a finer grained lock be used?

It has less to do with lock contention and much more to do with the
design of the tty / console layer.  It isn't the kernel's prettiest
code.

There is probably some cleanup that is possible, but really getting the
thing in gear (which means no BKL, which is probably the hardest part to
rip out) require some level of rewrite.

	Robert Love

