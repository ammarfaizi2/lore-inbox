Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQKBWY4>; Thu, 2 Nov 2000 17:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbQKBWYq>; Thu, 2 Nov 2000 17:24:46 -0500
Received: from pD9040D34.dip.t-dialin.net ([217.4.13.52]:62217 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S129819AbQKBWYj>;
	Thu, 2 Nov 2000 17:24:39 -0500
Subject: Re: test10 won't boot
To: adve@oce.nl (Arjan van de Ven)
Date: Thu, 2 Nov 2000 23:23:26 +0100 (CET)
Cc: hjb@pro-linux.de (Hans-Joachim Baader), linux-kernel@vger.kernel.org
In-Reply-To: <m13rFOP-000qDEC@pc1-adve.oce.nl> from "Arjan van de Ven" at Nov 02, 2000 09:06:37 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001102222327.467EF355279@grumbeer.hjb.de>
From: hjb@pro-linux.de (Hans-Joachim Baader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> [snip]
> 
> > CONFIG_M686=y
> 
> Ah ha!
> 
> You have selected the Pentium II/III CPU type, which does NOT work on a K6. 
> The compiler (and the kernel) will use the "new" Pentium II instructions
> (such as "cmov") which are not supported by the K6, leading to "illegal
> instruction" usage very early.

Ouch. This was it. I simply overlooked this option and used the one
that worked with 2.2...

But it would be nice if the kernel could detect the wrong CPU type
and print a message before it stops. Perhaps compile the init
section without CPU specific optimization?

Thanks for your help,
hjb
-- 
http://www.pro-linux.de/ - Germany's largest volunteer Linux support site
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
