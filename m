Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTBTKxR>; Thu, 20 Feb 2003 05:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBTKxR>; Thu, 20 Feb 2003 05:53:17 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:27849 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S265140AbTBTKxO>; Thu, 20 Feb 2003 05:53:14 -0500
Message-ID: <008601c2d8cf$a60e4c60$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Andi Kleen" <ak@suse.de>, "Simon Kirby" <sim@netnation.com>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <davem@redhat.com>
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel> <p73r8a3xub5.fsf@amdsimf.suse.de> <20030220092043.GA25527@netnation.com> <20030220093422.GA16369@wotan.suse.de> <006301c2d8c8$921c1d10$760010ac@edumazet> <20030220105435.GD10374@wotan.suse.de>
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Date: Thu, 20 Feb 2003 12:03:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Yes IP is best-effort. But this argument cant explain why IP on linux
works
> > better if we disable SMP on linux...
>
> It has nothing to do with SMP. The lazy locking dropping packets can
happen
> on UP kernels too in extreme cases. Also with preempt.
>

Well, I too noticed that binding NIC IRQS one one CPU

echo 1 > /proc/irq/18/smp_affinity

helps a lot in normal cases.

Some of us want SMP machine because application needs a lot of CPU, but we
also need to not drop frames to save the limited network bandwith.

Thanks

