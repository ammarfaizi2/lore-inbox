Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSICMSU>; Tue, 3 Sep 2002 08:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318756AbSICMSU>; Tue, 3 Sep 2002 08:18:20 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:55425 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318289AbSICMST>;
	Tue, 3 Sep 2002 08:18:19 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209031221.QAA01882@sex.inr.ac.ru>
Subject: Re: TCP Segmentation Offloading (TSO)
To: taka@valinux.co.jp (Hirokazu Takahashi)
Date: Tue, 3 Sep 2002 16:21:08 +0400 (MSD)
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       davem@redhat.com, christopher.leech@intel.com
In-Reply-To: <20020903.164243.21934772.taka@valinux.co.jp> from "Hirokazu Takahashi" at Sep 3, 2 04:42:43 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I guess it may also depend on bad implementations of csum_partial().
> It's wrong that some architecture assume every data in a skbuff are
> aligned on a 2byte boundary so that it would access a byte next to
> the the last byte where no pages might be there.

Access beyond end of skb is officially allowed, within 16 bytes
in <= 2.2, withing 64 bytes in  >=2.4. Moreover, it is not only allowed
but highly recommended, when this can ease coding.

> It's time to fix csum_partial().

Well, not depending on wrong accent put by you, the change is not useless.

Alexey


PS Gentlemen, it is not so bad idea to change subject and to trim cc list.
Thread is went to area straight orthogonal to TSO, csum_partial is not
used with TSO at all. :-)
