Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbSJ2BY0>; Mon, 28 Oct 2002 20:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJ2BY0>; Mon, 28 Oct 2002 20:24:26 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:41355 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261463AbSJ2BYY>;
	Mon, 28 Oct 2002 20:24:24 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210290130.EAA19804@sex.inr.ac.ru>
Subject: Re: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
To: alain@cscoms.net (Alain Fauconnet)
Date: Tue, 29 Oct 2002 04:30:25 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, lve@ns.aanet.ru
In-Reply-To: <20021028171956.A14460@cscoms.net> from "Alain Fauconnet" at Oct 28, 2 05:19:56 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I assume that the kernel is trying to use dynamic memory that has been
> released already, right?

Right.

> What's next in tracing this one down?

To tell what exactly driver makes this. Apparently, it continues
to inject packets to the stack even after it has been destroyed.

If you did not see message "Freeing alive device", this means
that driver unregistered it. Usual ppp seems to be sane...

Alexey
