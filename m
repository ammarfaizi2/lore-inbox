Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312266AbSCRJVM>; Mon, 18 Mar 2002 04:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312267AbSCRJVB>; Mon, 18 Mar 2002 04:21:01 -0500
Received: from ardbeg.madscilab.com ([213.136.48.97]:670 "EHLO
	hermes.madsci.se") by vger.kernel.org with ESMTP id <S312266AbSCRJUv>;
	Mon, 18 Mar 2002 04:20:51 -0500
Date: Mon, 18 Mar 2002 10:20:50 +0100 (CET)
From: Adam Johansson <macadam@madsci.se>
X-X-Sender: <macadam@macadam.madscilab.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Suspicious about 2.4.18
In-Reply-To: <200203180743.g2I7hfmj007702@bert.webservepro.com>
Message-ID: <Pine.LNX.4.33.0203181010520.7930-100000@macadam.madscilab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Michael wrote:

> I'm not really a linux expert, so I can only be suspicious.

Neither am I but I after seeing strange cron-jobs being run in the
future according to the log,I upgraded to 2.4.19pre3 and all was ok
again.

> Masquerading of iptables 1.2.5 sudently idles when "iptables -L" shows
> everything is alright. A realoading of rc.firewall brings everything back to
> normal. That happened 7 days after a normal operation. I've now upgraded to
> 1.2.6 and see what happens.
>
> Also, crond doesn't seem to operate very precisely. It is sometimes seems
> idle for 30 minutes.

I tried running this small script under 2.4.18 and noticed very strange
outputs..

// --- start ---
#!/bin/tcsh
while (1)
  date
end
// --- end ---

./timescript > output

output gives me this;
Fri Mar 15 10:17:12 CET 2002
Fri Mar 15 10:17:12 CET 2002
Fri Mar 15 10:17:12 CET 2002
Fri Mar 15 10:17:12 CET 2002
Fri Mar 15 10:17:12 CET 2002
Fri Mar 15 10:17:12 CET 2002
Fri Mar 15 11:29:43 CET 2002
Fri Mar 15 11:29:43 CET 2002
Fri Mar 15 11:29:43 CET 2002
Fri Mar 15 10:17:13 CET 2002
Fri Mar 15 10:17:13 CET 2002
Fri Mar 15 10:17:13 CET 2002
Fri Mar 15 10:17:13 CET 2002
Fri Mar 15 10:17:13 CET 2002
Fri Mar 15 10:17:13 CET 2002


Which clearly shows that something is very very strange.
I've no idea where or why this happens but since upgrading to 2.4.19pre3
helped I assume that there is something in the kernel that is wrong.
I run SuSE7.2 with a vanilla 2.4.18 (now 2.4.19pre3).

> I know that these may be application-specific problems, but I was curious if
> there are any current kernel issues related to them so I can quit searching
> for another cure.
>
> Thanks. Michael.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers! /Adam

-=-=-=-=-=-=-=-=-=-=-=-=-
Adam Johansson
Developer @ MadSci AB
Phone: +46 (0)18 606462
ICQ: 58187935
http://www.madsci.se
-=-=-=-=-=-=-=-=-=-=-=-=-

