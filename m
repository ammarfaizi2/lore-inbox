Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317675AbSGUP3b>; Sun, 21 Jul 2002 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317689AbSGUP3b>; Sun, 21 Jul 2002 11:29:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2294 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317675AbSGUP3a>; Sun, 21 Jul 2002 11:29:30 -0400
Subject: Re: [lmbench] tcp bandwidth on athlon
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020721132154.GA28089@rushmore>
References: <20020721132154.GA28089@rushmore>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 17:44:59 +0100
Message-Id: <1027269899.17234.104.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 14:21, rwhron@earthlink.net wrote:
> In Carl Staelin and Larry McVoy's 98 Usenix paper they wrote:
> 
> "It is interesting to compare pipes with TCP because the TCP  benchmark  is
> identical to the pipe benchmark except for the transport mechanism.  Ideally,
> the TCP bandwidth would be as good as the pipe bandwidth.  It is  not  widely
> known  that  the  majority of the TCP cost is in the bcopy, the checksum, and
> the network interface driver.  The checksum and  the  driver  may  be  safely

The paper however ignored something else we do which is why you see
csum_partial_copy_generic. On a modern processor the cost of fetching
and storing memory is so high compared to the throughput of the
processor that it is actually much more effective to fold the copy and
checksum together. Generally the copy/checksum has the same speed as a
pure copy anyway

