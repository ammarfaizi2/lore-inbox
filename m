Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRGVSKY>; Sun, 22 Jul 2001 14:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268019AbRGVSKP>; Sun, 22 Jul 2001 14:10:15 -0400
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:8232 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268017AbRGVSKM>; Sun, 22 Jul 2001 14:10:12 -0400
From: "Alan J. Wylie" <alan.nospam@glaramara.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15195.5892.311474.400006@glaramara.freeserve.co.uk>
Date: Sun, 22 Jul 2001 19:10:12 +0100
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: ipt_unclean: TCP flags bad: 4
In-Reply-To: <Pine.LNX.4.33.0107221947420.739-100000@Expansa.sns.it>
In-Reply-To: <15194.61662.338810.87576@glaramara.freeserve.co.uk>
	<Pine.LNX.4.33.0107221947420.739-100000@Expansa.sns.it>
X-Mailer: VM 6.93 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 22 Jul 2001 19:51:43 +0200 (CEST), Luigi Genoni <kernel@Expansa.sns.it> said:

> There was a bug introduced with kernel 2.4.6, but it was solved with
> one of the latest 2.4.7-pre patch, i do not remember which one.

> actually i was happily using tcp_unclean on my production servers,
> but with 2.4.6 i was forced to avoid it.  I still have to try 2.4.7
> to see if it works properly.

> If you use a rule like

> iptables -A INPUT -m unlean -j DROP
                       ^^^^^^
unclean, unclean <ding> ;-)

> are you still able to connect in/out of your box?

$MYIPTABLES --append INPUT   --match unclean --jump DROP

has been at the start of my rules for a long time. I wasn't seeing
any *serious* problems browsing the web, etc., but was getting a few
"unable to connect to host" pages. Some of them went away on refresh,
but some sites I just couldn't get to. On the other hand, that's
normal for the Internet.

-- 
Alan J. Wylie                        http://www.glaramara.freeserve.co.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  Antoine de Saint-Exupery
