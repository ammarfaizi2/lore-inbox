Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129543AbQK0U0X>; Mon, 27 Nov 2000 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129605AbQK0U0O>; Mon, 27 Nov 2000 15:26:14 -0500
Received: from netwinder.org ([207.245.35.202]:3326 "EHLO kei.netwinder.org")
        by vger.kernel.org with ESMTP id <S129543AbQK0UZz>;
        Mon, 27 Nov 2000 15:25:55 -0500
Message-ID: <3A22BC46.268C0FB3@netwinder.org>
Date: Mon, 27 Nov 2000 14:55:50 -0500
From: "Andrew E. Mileski" <andrewm@netwinder.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <Pine.LNX.3.95.1001127130021.760A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Mon, 27 Nov 2000, Andrew E. Mileski wrote:
> > Agreed, but that wasn't my point.  There is debug code in the current
> > kernel that defines DEBUG to something non-numeric, which causes
> > the compile to barf on kernel.h in some cases (try defining DEBUG in
> > your Makefile).  Instances of the offending code (there are SEVERAL)
> > and kernel.h should be fixed.
> >
> > Try this from the top level:
> >   grep -r DEBUG * | grep -v DEBUG_ | less
> 
> Yep. I now understand your point.

Actually, it would have been clearer with:
  grep -r '#define DEBUG' * | grep -v DEBUG_ | less

Given how hard it was to convice Linus to add his coding style guide
to the documentation, as he won't demand conformance, I doubt if there
will be easy getting people to conform to a standard use of DEBUG :(

I'll settle for fixing kernel.h though, and perhaps adding "use of
DEBUG" to the guidelines.

--
Andrew E. Mileski - Software Engineer
Rebel.com  http://www.rebel.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
