Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271889AbRHUWzA>; Tue, 21 Aug 2001 18:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271888AbRHUWyu>; Tue, 21 Aug 2001 18:54:50 -0400
Received: from mail.webmaster.com ([216.152.64.131]:21719 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271886AbRHUWyg>; Tue, 21 Aug 2001 18:54:36 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random entropy calcs - patch [not related to net devices]
Date: Tue, 21 Aug 2001 15:54:50 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMGEMODFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <9547398.998437243@[169.254.198.40]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +       time = (__u32)(xtime.tv_usec) ^ (__u32)(xtime.tv_sec);

	I would prefer:

	time = (__u32)xtime.tv_usec | ( (__u32)(xtime.tv_sec)<<20) );

	The way you have it, you collide the two least-significant bits,
potentially losing some entropy.

	DS

