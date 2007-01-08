Return-Path: <linux-kernel-owner+w=401wt.eu-S1161195AbXAHIbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbXAHIbq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbXAHIbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:31:46 -0500
Received: from web55604.mail.re4.yahoo.com ([206.190.58.228]:36929 "HELO
	web55604.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161195AbXAHIbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:31:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Dpu4xdlX4SAdrzyogyiMynW8xW8j0dh2veR1+guyNFc3DNpVIAMnusqFX/6QJwsngjWzoNxb3Yqu+YyfOo8Za+nxQ/m3wUOWh1LdL7CHbbETia2PzxGIfjgQadoa9C9j9P3SaoF3ehXjQyU/Rn172gfip2L3p33c6osCksEyO44=;
X-YMail-OSG: fvpsNLIVM1k_FF30MiLprbDTXnA_i7Mn7shp8_sRkMNKsLyUx8xeJPrhUcH1Dq6ZStF6niID5BTrJhJFu4hWQPlkdDw2uMjk2ju3hrAVwLPi7iu.crvmr.Ohg4Ouc_N7ncK0ZLQadgCzivc-
Date: Mon, 8 Jan 2007 00:31:44 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>
Cc: Amit Choudhary <amit2030@yahoo.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <810563.91187.qm@web55604.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On 1/8/07, Hua Zhong <hzhong@gmail.com> wrote:
> > > And as I explained, it can result in longer code too. So, why
> > > keep this value around. Why not re-initialize it to NULL.
> >
> > Because initialization increases code size.
> 
> And it also effectively blocks the slab debugging code from doing its
> job detecting double-frees.
> 

Man, so you do want someone to set 'x' to NULL after freeing it, so that the slab debugging code
can catch double frees. If you set it to NULL then double free is harmless. So, you want something
harmful in the system and then debug it with the slab debugging code. Man, doesn't make sense to
me.

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
