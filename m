Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131441AbRATXxD>; Sat, 20 Jan 2001 18:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131678AbRATXwx>; Sat, 20 Jan 2001 18:52:53 -0500
Received: from mserv1c.vianw.co.uk ([195.102.240.33]:47572 "EHLO
	mserv1c.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S131441AbRATXws>; Sat, 20 Jan 2001 18:52:48 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Date: Sat, 20 Jan 2001 23:55:13 +0000
Organization: [private individual]
Message-ID: <cv8k6ts9oeb72pmhh9hsfjta6uen511a0j@4ax.com>
In-Reply-To: <20010120215641.A1818@suse.cz> <Pine.LNX.4.10.10101201301200.657-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10101201301200.657-100000@master.linux-ide.org>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001 14:57:07 -0800 (PST), Andre Hedrick wrote:

...
>
>Vojtech, I worry that the dynamic timing that you are calculating could
>bite you.  Timings are exact especially at modes 3/4/5 the margins go to
>an effective zero for varition or wiggle room.  The state diagrams from
>Quantum that created the Ultra DMA 0,1,2,3,4,5 show how darn tight it
>constrained.  You need to assume absolutes because the various board
>makers screw up the skew tables by the PCB lane traces.
>

I am not sure this is just a question of small variations.  The hdparm
-t differences between these two versions is quite significant.  This
evidence would imply that the two approaches are making fundemental
different decisions about what my hardware can do!

Under 2.2.17

/dev/hda:
 Timing buffered disk reads:  64 MB in 21.86 seconds =  2.93 MB/sec

/dev/hdc:
 Timing buffered disk reads:  64 MB in 20.81 seconds =  3.08 MB/sec

Under 2.4.0

/dev/hda:
 Timing buffered disk reads:  64 MB in  6.58 seconds =  9.73 MB/sec

/dev/hdc:
 Timing buffered disk reads:  64 MB in  6.59 seconds =  9.71 MB/sec

Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
