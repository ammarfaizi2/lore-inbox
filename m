Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHDAJZ>; Fri, 3 Aug 2001 20:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269724AbRHDAJP>; Fri, 3 Aug 2001 20:09:15 -0400
Received: from jalon.able.es ([212.97.163.2]:43747 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S269726AbRHDAI5>;
	Fri, 3 Aug 2001 20:08:57 -0400
Date: Sat, 4 Aug 2001 02:13:04 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: root@chaos.analogic.com
Cc: Andrey Ilinykh <ailinykh@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: fake loop
Message-ID: <20010804021304.A21339@werewolf.able.es>
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net> <Pine.LNX.3.95.1010803123040.675A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.95.1010803123040.675A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Aug 03, 2001 at 18:44:00 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010803 Richard B. Johnson wrote:
>
>Yes! This is neat! The { } defines a new program unit. Therefore,
>you can allocate temporary variables within it, like:
>
>    do {
>        int i;
>        for(i=0; i< MAX; i++)
>          do_something(i);
>       } while (0);
>

I have heard many times that kernel is not thought to be compiled by anything
but gcc. Please, start useing gcc features, like statement expressions:

({
	int i;
	for(i=0; i< MAX; i++)
		do_something(i); 
})
-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7-ac3 #1 SMP Mon Jul 30 16:39:36 CEST 2001 i686
