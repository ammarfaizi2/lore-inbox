Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRAWVhu>; Tue, 23 Jan 2001 16:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRAWVhk>; Tue, 23 Jan 2001 16:37:40 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:38148 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129884AbRAWVhX>; Tue, 23 Jan 2001 16:37:23 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101232137.NAA02344@cx518206-b.irvn1.occa.home.com>
Subject: Re: 2.4 cpu usage...
To: law@sgi.com (LA Walsh)
Date: Tue, 23 Jan 2001 13:37:32 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (lkml)
Reply-To: barryn@pobox.com
In-Reply-To: <NBBBJGOOMDFADJDGDCPHMEDDCKAA.law@sgi.com> from "LA Walsh" at Jan 23, 2001 12:32:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh wrote:
[snip]
> So the kapm thing could be a "display" / accounting problem, but the
> slowdown in vmware/X was real.  I ran a WIN Norton "Benchmark" -- comes
> up reliably over "300" -- usually around 320-350 under 2.2.17.  Under
> 2.4, it came up reliably *under* 300 with typical being about 265".
> 
> So...I'm bummed.  I'm assuming a 30% degradation in an app is probably
> not expected behavior?  Swap usage is '0' in both OS's (i.e. it's not
> a run out of memory issue).

I actually saw a similar type of slowdown on my Inspiron 5000e with 2.4
(test10preX or test11preX, where I forget what X was, probably 5 or so).

Specifically, the following command read off the disk more slowly:

gzip -1 < /dev/hda | nc some_other_box some_port -w 1

even when I got rid of the gzip -1 (redirecting /dev/hda straight into nc,
or piping cat into nc).

In my case, the slowdown was clearly visible - the disk light was at full
brightness under 2.2.16, but not 2.4.0testwhatever.

I wanted to try again without any APM stuff in the kernel (or at least,
not APM CPU idling) before reporting it, but I never got a chance to do
that.

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
