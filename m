Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270660AbUJUG0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270660AbUJUG0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270415AbUJTT2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:28:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:21255 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269170AbUJTTOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:14:43 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Date: Wed, 20 Oct 2004 22:14:31 +0300
User-Agent: KMail/1.5.4
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
References: <1098230132.23628.28.camel@krustophenia.net> <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua> <1098290858.1429.70.camel@krustophenia.net>
In-Reply-To: <1098290858.1429.70.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410202214.31791.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 19:47, Lee Revell wrote:
> On Wed, 2004-10-20 at 11:11, Denis Vlasenko wrote:
> > 0x57 == 87 bytes is too big for inline.
> 
> Ugh.  So the only fix is not to inline it?

Yes.

You can make it conditionally inline/non-inline
depending on SMP/preempt if you feel masochistic today :),
but last time I asked davem thought that it is over the top.

Deinline it.
--
vda

