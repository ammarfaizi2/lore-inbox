Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136318AbRECJt2>; Thu, 3 May 2001 05:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136326AbRECJtT>; Thu, 3 May 2001 05:49:19 -0400
Received: from t2.redhat.com ([199.183.24.243]:43760 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136318AbRECJtL>; Thu, 3 May 2001 05:49:11 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AF10E80.63727970@alsa-project.org> 
In-Reply-To: <3AF10E80.63727970@alsa-project.org>  <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> 
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 10:45:28 +0100
Message-ID: <11718.988883128@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


abramo@alsa-project.org said:
>  The problem I see is that with the former solution nothing prevents
> from to do:

> 	regs->reg2 = 13;

> That's indeed the reason to change ioremap prototype for 2.5. 

An alternative is to add an fixed offset to the cookie before returning it, 
and subtract it again in {read,write}[bwl].

--
dwmw2


