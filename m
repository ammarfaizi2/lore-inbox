Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRDDBOt>; Tue, 3 Apr 2001 21:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRDDBOk>; Tue, 3 Apr 2001 21:14:40 -0400
Received: from chromium11.wia.com ([207.66.214.139]:32005 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S131724AbRDDBOg>; Tue, 3 Apr 2001 21:14:36 -0400
Message-ID: <3ACA7629.E8C54D13@chromium.com>
Date: Tue, 03 Apr 2001 18:17:30 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: a quest for a better scheduler
In-Reply-To: <E14kbH2-0000qX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > for the "normal case" performance see my other message.
>
> I did - and with a lot of interest

thanks! :)

> > I agree that a better threading model would surely help in a web server, but to
> > me this is not an excuse to live up with a broken scheduler.
>
> The problem has always been - alternative scheduler, crappier performance for
> 2 tasks running (which is most boxes). If your numbers are right then the
> HP patch is working as well for 1 or 2 tasks too

Please verify them if you have a couple of spare hours.

BTW: I measured similar results for the "scalability" patches on a 2.4.1 kernel, it
would be worth the effort to seriously compare them from an architectural point of
view, but I don't have the time right now...

> > Unless we want to maintain the position tha the only way to achieve good
> > performance is to embed server applications in the kernel, some minimal help
> > should be provided to goodwilling user applications :)
>
> Indeed. I'd love to see you beat tux entirely in userspace.  It proves the
> rest of the API for the kernel is right

Indeed, I'm using RT sigio/sigwait event scheduling, bare clone threads and
zero-copy io.

If only I had a really asynchronous sendfile, or a smarter madvise that wouldn't
require to map files :)

My server cannot execute dynamic stuff yet, it relies on Apache for that.

Running X15 and TUX in the same conditions (i.e. dynamic code in Apache) I get
exactly the same score in both cases.

I'm adding a TUX-like dynamic interface, I hope to get it to work by next week, then
I'll make a real confrontation.

Regards, ciao,

 - Fabio


