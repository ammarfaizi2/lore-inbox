Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132473AbRCaS2T>; Sat, 31 Mar 2001 13:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRCaS2J>; Sat, 31 Mar 2001 13:28:09 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:43024 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132473AbRCaS1v>;
	Sat, 31 Mar 2001 13:27:51 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103311826.WAA22134@ms2.inr.ac.ru>
Subject: Re: udp <-> tcp connect
To: sasa@pheniscidae.satimex.tvnet.HU (SZALAY Attila)
Date: Sat, 31 Mar 2001 22:26:40 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010329150851.D11306@pheniscidae.satimex.tvnet.hu> from "SZALAY Attila" at Mar 29, 1 05:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I want to bind to non-local IP and send/receive UDP packets.

This is impossible, apparently.


> but in tcp_v4_connect:
>         tmp = ip_route_connect(&rt, nexthop, sk->saddr,
>               RT_TOS(sk->ip_tos)|RTO_CONN|sk->localroute, sk->bound_dev_if);
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^

And this is __terrible__ bug. RTO_CONN cannot be set here.

Alexey
