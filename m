Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbTCZXYO>; Wed, 26 Mar 2003 18:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbTCZXYO>; Wed, 26 Mar 2003 18:24:14 -0500
Received: from intra.cyclades.com ([64.186.161.6]:55207 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S262627AbTCZXYN>; Wed, 26 Mar 2003 18:24:13 -0500
Message-ID: <3E81C846.6010901@cyclades.com>
Date: Wed, 26 Mar 2003 15:33:26 +0000
From: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Reply-To: henrique.gobbi@cyclades.com
Organization: Cyclades Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interpretation of termios flags on a serial driver
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org> <20030326092010.3EDA8124023@mx12.arcor-online.net> <3E81BE5C.400@cyclades.com> <Pine.LNX.4.53.0303261804020.2833@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback.

> If PARENB is set you generate parity. It is ODD parity if PARODD
> is set, otherwise it's EVEN. There is no provision to generate
> "stick parity" even though most UARTS will do that. When you
> generate parity, you can also ignore parity on received data if
> you want.  This is the IGNPAR flag.

Ok. But, considering the 2 states of the flag IGNPAR, what should the 
driver do with the chars that are receiveid with wrong parity, send this 
data to the TTY with the flag TTY_PARITY or just discard this data ?

regards
Henrique


