Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSA1KUR>; Mon, 28 Jan 2002 05:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSA1KUH>; Mon, 28 Jan 2002 05:20:07 -0500
Received: from [195.66.192.167] ([195.66.192.167]:21007 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286462AbSA1KTx>; Mon, 28 Jan 2002 05:19:53 -0500
Message-Id: <200201281018.g0SAIIE22462@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Date: Mon, 28 Jan 2002 12:18:20 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com> <3C51FF0C.D3B1E2F7@zip.com.au>
In-Reply-To: <3C51FF0C.D3B1E2F7@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <thinks of another>
>
> 	s/inline//g

I like this.

Plain grep turned out hundreds of 'inline' (I didn't even count).
I'd like to write a script which will narrow it to:

.... inline .... {
   more than 2 lines
}

But my knowledge of grep/sed/perl/awk/??? magic is really not up to the task.

Plan:
* replace those with big_inline
* #define it to 'inline' or to '' (nothing) and compare kernel sizes
* make it CONFIG_xxx option if it worth the trouble
--
vda
