Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbTC0B0E>; Wed, 26 Mar 2003 20:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbTC0B0E>; Wed, 26 Mar 2003 20:26:04 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46479 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262737AbTC0B0D>; Wed, 26 Mar 2003 20:26:03 -0500
Date: Wed, 26 Mar 2003 20:41:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: henrique.gobbi@cyclades.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Interpretation of termios flags on a serial driver
In-Reply-To: <3E81C846.6010901@cyclades.com>
Message-ID: <Pine.LNX.4.53.0303262035230.3287@chaos>
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
 <20030326092010.3EDA8124023@mx12.arcor-online.net> <3E81BE5C.400@cyclades.com>
 <Pine.LNX.4.53.0303261804020.2833@chaos> <3E81C846.6010901@cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Henrique Gobbi wrote:

> Thanks for the feedback.
>
> > If PARENB is set you generate parity. It is ODD parity if PARODD
> > is set, otherwise it's EVEN. There is no provision to generate
> > "stick parity" even though most UARTS will do that. When you
> > generate parity, you can also ignore parity on received data if
> > you want.  This is the IGNPAR flag.
>
> Ok. But, considering the 2 states of the flag IGNPAR, what should the
> driver do with the chars that are receiveid with wrong parity, send this
> data to the TTY with the flag TTY_PARITY or just discard this data ?
>
> regards
> Henrique
>


If the IGNPAR flag is true, you keep the data. You pretend it's
okay. Ignore parity means just that. Ignore it. You do not flag
it in any way. This is essential. If you have a 7-bit link and
somebody is sending you stick-parity, you can still use the data.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

