Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132278AbQLHRAw>; Fri, 8 Dec 2000 12:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbQLHRAn>; Fri, 8 Dec 2000 12:00:43 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:45574 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S132278AbQLHRAd>; Fri, 8 Dec 2000 12:00:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14897.3214.38818.625199@somanetworks.com>
Date: Fri, 8 Dec 2000 11:30:06 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: georgn@somanetworks.com, linux-kernel@vger.kernel.org,
        greg@wind.enjellic.com, sct@redhat.com
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: <5597.976229508@ocs3.ocs-net>
In-Reply-To: <14895.51841.431444.405949@somanetworks.com>
	<5597.976229508@ocs3.ocs-net>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "KO" == Keith Owens <kaos@ocs.com.au> writes:

 KO> You only removed the module symbol handling.  The problem is that
 KO> the entire klogd oops handling is out of date and broken.  I
 KO> recommend removing all oops processing from klogd, which means
 KO> that klogd does not need any symbols nor System.map.

You're right.  

My goal was to quickly get our build working again.  I had no
expectation that anybody else on the planet would give a crap about my
patch...

But since you seem to and while we're doing extreme surgery, why have
klogd at all?  Every other unix, kernel messages are handled by the
syslog system.  What problem did klogd solve and does that problem
still exist today?  Stated differently, aren't you just proposing to
reduce klogd to:

	cat < /proc/kmsg > /dev/log &

(I know that this won't work on my box, but you get the idea)

Anyway, I'll look into simplifying klogd as you suggest...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
