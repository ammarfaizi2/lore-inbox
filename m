Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbRAOPgg>; Mon, 15 Jan 2001 10:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbRAOPg0>; Mon, 15 Jan 2001 10:36:26 -0500
Received: from mail.zmailer.org ([194.252.70.162]:55817 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130144AbRAOPgX>;
	Mon, 15 Jan 2001 10:36:23 -0500
Date: Mon, 15 Jan 2001 17:36:07 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jonathan Thackray <jthackray@zeus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010115173607.S25659@mea-ext.zmailer.org>
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com> <14947.5703.60574.309140@leda.cam.zeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14947.5703.60574.309140@leda.cam.zeus.com>; from jthackray@zeus.com on Mon, Jan 15, 2001 at 03:24:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 03:24:55PM +0000, Jonathan Thackray wrote:
> It's a very useful system call and makes file serving much more
> scalable, and I'm glad that most Un*xes now have support for it
> (Linux, FreeBSD, HP-UX, AIX, Tru64). The next cool feature to add to
> Linux is sendpath(), which does the open() before the sendfile()
> all combined into one system call.

	One thing about 'sendfile' (and likely 'sendpath') is that
	current (hammered into running binaries -> unchangeable)
	syscalls support only up to 2GB files at 32 bit systems.

	Glibc 2.2(9) at RedHat  <sys/sendfile.h>:

#ifdef __USE_FILE_OFFSET64
# error "<sendfile.h> cannot be used with _FILE_OFFSET_BITS=64"
#endif


	I do admit that doing  sendfile()  on some extremely large
	file is unlikely, but still...

> Ugh, I hear you all scream :-)
> Jon.
> -- 
> Jonathan Thackray         Zeus House, Cowley Road, Cambridge CB4 OZT, UK
> Zeus Technology                                     http://www.zeus.com/

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
