Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSHPNDe>; Fri, 16 Aug 2002 09:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSHPNDe>; Fri, 16 Aug 2002 09:03:34 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:50693 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S318345AbSHPNDe>; Fri, 16 Aug 2002 09:03:34 -0400
Date: Fri, 16 Aug 2002 23:07:22 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: kuznet@ms2.inr.ac.ru
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
In-Reply-To: <200208152236.CAA27992@sex.inr.ac.ru>
Message-ID: <Mutt.LNX.4.44.0208162239370.687-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002 kuznet@ms2.inr.ac.ru wrote:

> I do not know what forced you to use BKL.

All existing paths which write to the pid/uid/euid fields are protected by
the BKL (except for the futex code, which doesn't need it).  None of
these, or the new paths which grab the BKL, are performance critical, as
they're ioctl() or fcntl() handlers.

> But I daresay this is deadlock:

Yep.


- James
-- 
James Morris
<jmorris@intercode.com.au>



