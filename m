Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSGQWaC>; Wed, 17 Jul 2002 18:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSGQWaC>; Wed, 17 Jul 2002 18:30:02 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:8171 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316795AbSGQWaB>; Wed, 17 Jul 2002 18:30:01 -0400
Message-Id: <5.1.0.14.2.20020717153013.09006b48@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 15:32:04 -0700
To: kuznet@ms2.inr.ac.ru, Jack.Bloch@icn.siemens.COM (Bloch Jack)
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: Networking question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207161700.VAA14214@sex.inr.ac.ru>
References: <180577A42806D61189D30008C7E632E8793998@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > the priority of the softirq daemon or ensure that it is always awoken 
> when a
> > netif_rx is called?
>
>You should suppound it with local_bh_disable()/enable(), when using
>from process context.
Actually he should call netif_rx_ni() instead of netif_rx().
_ni stands for non-interrupt context.

Max

