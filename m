Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSF0Qe2>; Thu, 27 Jun 2002 12:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSF0Qe1>; Thu, 27 Jun 2002 12:34:27 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:46216 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316882AbSF0Qe1>;
	Thu, 27 Jun 2002 12:34:27 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206271634.UAA16378@sex.inr.ac.ru>
Subject: Re: Fragment flooding in 2.4.x/2.5.x
To: trond.MYklebust@fys.uio.NO (Trond Myklebust)
Date: Thu, 27 Jun 2002 20:34:34 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206271757.39577.trond.myklebust@fys.uio.no> from "Trond Myklebust" at Jun 27, 2 08:15:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Did you not solve this problem using right write_space?
I remember we have already discussed this and to all that I remember
come to happy end. :-)

> Would such a patch be acceptable,

No, of course. :-)

>	       or is there a better way of doing this?

Better way exists. Just use forced sock_wmalloc instead of
sock_alloc_send_skb on non-blocking send of all the fragments
but the first.

But I still hope you will start with tuning your write_space
to send only when ~2*msg_size of space is available.

Alexey
