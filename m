Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSF0Q6M>; Thu, 27 Jun 2002 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSF0Q6L>; Thu, 27 Jun 2002 12:58:11 -0400
Received: from pat.uio.no ([129.240.130.16]:50052 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316878AbSF0Q6K>;
	Thu, 27 Jun 2002 12:58:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: kuznet@ms2.inr.ac.ru
Subject: Re: Fragment flooding in 2.4.x/2.5.x
Date: Thu, 27 Jun 2002 19:00:22 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200206271634.UAA16378@sex.inr.ac.ru>
In-Reply-To: <200206271634.UAA16378@sex.inr.ac.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206271900.22602.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 June 2002 18:34, kuznet@ms2.inr.ac.ru wrote:

> Did you not solve this problem using right write_space?

Sure, I can add specific checks for (atomic_read(&sk->wmem_alloc) < 
sk->sndbuf) in the RPC layer, however, I don't see why such a check couldn't 
be put into ip_build_xmit() itself. Sending partial messages isn't a feature 
that sounds like it would be particularly useful for any other applications 
either.

However what if the actual call to alloc_skb() fails?

Cheers,
  Trond
