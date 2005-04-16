Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVDPLZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVDPLZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 07:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVDPLZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 07:25:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:64528 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262582AbVDPLZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 07:25:43 -0400
Date: Sat, 16 Apr 2005 21:23:29 +1000
To: Thomas Graf <tgraf@suug.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>, hadi@cyberus.ca,
       netdev <netdev@oss.sgi.com>, Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>,
       kuznet@ms2.inr.ac.ru, devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
Message-ID: <20050416112329.GA31847@gondor.apana.org.au>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain> <20050415225422.GF4114@postel.suug.ch> <20050416014906.GA3291@gondor.apana.org.au> <20050416110639.GI4114@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416110639.GI4114@postel.suug.ch>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 01:06:39PM +0200, Thomas Graf wrote:
> 
> It's not completely useless, it speeds up the deletion classful
> qdiscs having some depth. However, it's not worth the locking
> troubles I guess.

RCU is meant to optimise the common reader path.  In this case
that's the packet transmission code.  Unfortunately it fails
miserably when judged by that criterion.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
