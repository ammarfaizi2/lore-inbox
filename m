Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSLMFVl>; Fri, 13 Dec 2002 00:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSLMFVl>; Fri, 13 Dec 2002 00:21:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13997 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261433AbSLMFVj>;
	Fri, 13 Dec 2002 00:21:39 -0500
Date: Thu, 12 Dec 2002 21:23:35 -0800 (PST)
Message-Id: <20021212.212335.127426137.davem@redhat.com>
To: matti.aarnio@zmailer.org
Cc: niv@us.ibm.com, alan@lxorguk.ukuu.org.uk, stefano.andreani.ap@h3g.it,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021213033928.GK32122@mea-ext.zmailer.org>
References: <1039727809.22174.38.camel@irongate.swansea.linux.org.uk>
	<3DF94565.2C582DE2@us.ibm.com>
	<20021213033928.GK32122@mea-ext.zmailer.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matti Aarnio <matti.aarnio@zmailer.org>
   Date: Fri, 13 Dec 2002 05:39:28 +0200

   On Thu, Dec 12, 2002 at 06:26:45PM -0800, Nivedita Singhvi wrote:
   > Assuming you are on a local lan, your round trip
   > times are going to be much less than 200 ms, and
   > so using the TCP_RTO_MIN of 200ms ("The algorithm 
   > ensures that the rto cant go below that").
   
     The RTO steps in only when there is a need to RETRANSMIT.
     For that reason, it makes no sense to place its start
     any shorter.

Actually, TCP_RTO_MIN cannot be made any smaller without
some serious thought.

The reason it is 200ms is due to the granularity of the BSD
TCP socket timers. 

In short, the repercussions are not exactly well known, so it's
a research problem to fiddle here.
