Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSKGS7O>; Thu, 7 Nov 2002 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSKGS7O>; Thu, 7 Nov 2002 13:59:14 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:50329 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261367AbSKGS7N>;
	Thu, 7 Nov 2002 13:59:13 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200211071905.WAA10317@sex.inr.ac.ru>
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
To: ahu@ds9a.nl (bert hubert)
Date: Thu, 7 Nov 2002 22:05:43 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021107184125.GA840@outpost.ds9a.nl> from "bert hubert" at Nov 7, 2 07:41:25 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> add 10.0.0.216 1.2.3.4 esp 34501 -E 3des-cbc "123456789012123456789012";

should read:

add 10.0.0.216 1.2.3.4 esp 34501
    -m tunnel
    -E 3des-cbc "123456789012123456789012";

KAME allows to use single SA both for transport and for tunnel,
we do not.

Actually, if you used setkey -D and setkey -DP to look at SAD/SPD,
you would notice this.

Alexey
