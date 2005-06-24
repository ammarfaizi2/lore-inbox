Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVFXDt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVFXDt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVFXDt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:49:26 -0400
Received: from graphe.net ([209.204.138.32]:938 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263024AbVFXDtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:49:19 -0400
Date: Thu, 23 Jun 2005 20:49:17 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
In-Reply-To: <20050623.204702.26274560.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506232047450.29103@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
 <20050623.203647.88475017.davem@davemloft.net> <Pine.LNX.4.62.0506232037430.28814@graphe.net>
 <20050623.204702.26274560.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, David S. Miller wrote:

> From: Christoph Lameter <christoph@lameter.com>
> Date: Thu, 23 Jun 2005 20:40:25 -0700 (PDT)
> 
> > Nothing as far as I can tell. The main benefit may be reorganization of 
> > the code.
> 
> You told us way back in the original thread that the final atomic dec
> shows up very much on NUMA, and if it could be avoided (and changed
> into a read test), it would help a lot on NUMA.

No I told you that we need to disassemble the atomic dec_and_test 
in order to be able to split the counters.

> > Yes and it was recently changed. Typical use is linux-xxx@vger.kernel.org
> 
> netdev@oss.sgi.com is what used to be the place for networking
> stuff, it's not netdev@vger.kernel.org

s/not/now/ right?
