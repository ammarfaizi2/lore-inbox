Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288099AbSACAqO>; Wed, 2 Jan 2002 19:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288085AbSACAoj>; Wed, 2 Jan 2002 19:44:39 -0500
Received: from t2.redhat.com ([199.183.24.243]:24308 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288076AbSACAfn>; Wed, 2 Jan 2002 19:35:43 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> 
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 00:35:30 +0000
Message-ID: <25193.1010018130@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(cc list trimmed)

alan@lxorguk.ukuu.org.uk said:
>  If you want a strcpy that isnt strcpy then change its name or use a
> different language 8)

The former is not necessarily sufficient in this case. You've still done the
broken pointer arithmetic, so even if the function isn't called strcpy() the
compiler is _still_ entitled to replace it with a call to memcpy() or even
machine_restart() before sleeping with your mother and starting WW III.

Granted, it probably _won't_ do any of those today, but you should know
better than to rely on that.

What part of 'undefined behaviour' is so difficult for people to understand?

--
dwmw2


