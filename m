Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270001AbRHQJQc>; Fri, 17 Aug 2001 05:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270012AbRHQJQW>; Fri, 17 Aug 2001 05:16:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270001AbRHQJQI>; Fri, 17 Aug 2001 05:16:08 -0400
Subject: Re: 2.4.9 does not compile [PATCH]
To: davem@redhat.com (David S. Miller)
Date: Fri, 17 Aug 2001 10:11:17 +0100 (BST)
Cc: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 16, 2001 04:38:52 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xfev-0006zJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Anton Altaparmakov <aia21@cam.ac.uk>
>    Date: Fri, 17 Aug 2001 00:22:43 +0100
>    
>    IMHO, it would have been more elegant to use the typeof construct provided 
>    by gcc in the new macro instead of introducing a type parameter like this...
> 
> The whole point was to make users explicitly state the type so they
> would have to think about it.

And doing it by forcing them all to change their macro names isnt the
right solution. Its actually basically impossible to do back compat macros
with this mess. Your original smin() umin() proposal was _much_ saner.

As I've said, -ac will use typed_min(a,b,c), and that way I can propogate
back compatibility glue.

Alan
