Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKHLoZ>; Wed, 8 Nov 2000 06:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129239AbQKHLoQ>; Wed, 8 Nov 2000 06:44:16 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:34554 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129092AbQKHLoJ>;
	Wed, 8 Nov 2000 06:44:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10011071301580.6012-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.10.10011071301580.6012-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test11-pre1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 11:44:02 +0000
Message-ID: <7964.973683842@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>   - Keith Owens: clean up module information passing, remove
>       "get_module_symbol()".

Please don't do this in one go. Flag days are bad.

	1. Add the inter_module_xxx stuff.
	2. Let it propagate into 2.2. get_module_symbol() is actually
		broken there, although I'd fixed it in 2.4.
	3. Let the existing users convert.
	4. _Then_ remove get_module_symbol().


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
