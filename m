Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTA1Xx7>; Tue, 28 Jan 2003 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTA1Xx7>; Tue, 28 Jan 2003 18:53:59 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:12707 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261934AbTA1Xx7>;
	Tue, 28 Jan 2003 18:53:59 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301290002.DAA30327@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
To: davem@redhat.com (David S. Miller)
Date: Wed, 29 Jan 2003 03:02:53 +0300 (MSK)
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
In-Reply-To: <20030128.152102.12708956.davem@redhat.com> from "David S. Miller" at Jan 28, 3 03:21:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> BTW, how come tcp_trim_head() can just set skb->ip_summed
> blindly to CHECKSUM_HW and not setup skb->csum?

When skb->ip_summed is CHECKSUM_HW skb->csum is ignored and
initialized at the moment when segment is transmitted in
tcp_v*_send_check().

Alexey
